Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB87A569D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 02:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjISAeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 20:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISAeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 20:34:22 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E7610E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:34:16 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c26aa19b7so30016597b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695083655; x=1695688455; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4iVww4emIQeBLcwE+/QrgHWHPyGhkEX3WLpqIu27nw=;
        b=WUTDcF7bvv9Y42C2QVFyOt7RixFXTdZVHMoN1pLYUXvexkYqoGkVZw8OlVlX6aBR/S
         br1UvPWEOOT9YoGgrERu9aRD/nHiQwU9xgJtYZsYBR06raaZmWdZOpQII2lXVta8HJWQ
         GPJfOqKdA6PGNKUL8S8DVz+4f/zQee3k25mF6mpYl0vchlY2MlIyXoXYVizKeGNOXkhG
         95hmTalv4V7OqiKaEbaD8fuVQ7EXDe3bgxxChbcYjpZHdpVE89HOgJ0B6Mg36wMf6NlK
         F1QB9iPtfbIahJ6EarGdJ2BitstaES0BGuQF47nV8ZIFFVwmQMtF4OR02c8AOr+R2sdu
         hMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695083655; x=1695688455;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4iVww4emIQeBLcwE+/QrgHWHPyGhkEX3WLpqIu27nw=;
        b=Pn1v+RYGa0AAQDIuWuuTekkt0iVpnL5FnHGlUk8rapEPWUAUDRXbd7LHPT5McYgf6Z
         XZWBfncl5oyQ+5u6dBqtHqgcYjh2EgEwLBlrwky6nfH1QZIcgkkh76vVALHvfxyydE0B
         rv1LMtX2P2woqAwGVkucR9lkqOsFyr3abvOwybr+chBz23pf6QhyOTGaAO6Wc7AZQy7h
         XKSGa9sVL9dKSdcV8pI5wtPrBJ+BcZ6NIm7qXLNUrwQwKLUtLQ1IH8m/bS0I4G4P3UO6
         fSwYwPDtIzrC0y/5Y9ouma4Pryf9iFnNu2t/siF95/WDHyCRG18iwDgbKkL+f5Cz2dzG
         EMaQ==
X-Gm-Message-State: AOJu0Yxbxj8WWckJF0IeGbsoyF77Y6MIaJwOgVnxzs5MSkjgrPuBestS
        WuHxIq3TPFqr03ECUVjywb3vPg==
X-Google-Smtp-Source: AGHT+IH/4jCzJSAyyqdUyjR+gvcjeYNIHEJ787FKwQEYZHvi4ny1ZqgNG+nSPDzubJTaUH5jTeg0gw==
X-Received: by 2002:a25:258d:0:b0:d16:7ccc:b407 with SMTP id l135-20020a25258d000000b00d167cccb407mr10591046ybl.39.1695083654951;
        Mon, 18 Sep 2023 17:34:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e202-20020a25e7d3000000b00d7b9fab78bfsm2622081ybh.7.2023.09.18.17.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 17:34:14 -0700 (PDT)
Date:   Mon, 18 Sep 2023 17:34:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
In-Reply-To: <CAHbLzkoQV_1LzxtdEazfPmSEh+CgRLpED6nxdTZ1D=2D1HwV4g@mail.gmail.com>
Message-ID: <a76aaf3e-c63b-6dd1-a1bf-feea397376a6@google.com>
References: <ZP/3hgDCXeceE9uU@casper.infradead.org> <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com> <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com> <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com> <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com> <ZQNaT/3xPxATKJVR@casper.infradead.org>
 <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com> <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com> <ZQN58hFWfgn+OfvG@casper.infradead.org> <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com> <CAHbLzkrmTaqBRmHVdE2kyW57Uoghqd_E+jAXC9cB5ofkhL-uvw@mail.gmail.com> <fc874e32-2a69-50ae-b1c9-5a982f16e1f1@google.com> <CAHbLzkoQV_1LzxtdEazfPmSEh+CgRLpED6nxdTZ1D=2D1HwV4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-961474384-1695083654=:22034"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-961474384-1695083654=:22034
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 18 Sep 2023, Yang Shi wrote:
> On Fri, Sep 15, 2023 at 8:57=E2=80=AFPM Hugh Dickins <hughd@google.com> w=
rote:
> > On Fri, 15 Sep 2023, Yang Shi wrote:
> > >
> > > Hi Suren and Hugh,
> > >
> > > Thanks for figuring this out. The mbind behavior is a little bit mess=
y
> > > and hard to follow. I tried my best to recall all the changes.
> >
> > Messy and confusing yes; and for every particular behavior, I suspect
> > that by now there exists some release which has done it that way.
> >
> > >
> > > IIUC, mbind did break the vma iteration early in the first place, the=
n
> > > commit 6f4576e3687b ("mempolicy: apply page table walker on
> > > queue_pages_range()") changed the behavior (didn't break vma iteratio=
n
> > > early for some cases anymore), but it messed up the return value and
> > > caused some test cases failure, also violated the manual. The return
> > > value issue was fixed by commit a7f40cfe3b7a ("mm: mempolicy: make
> > > mbind() return -EIO when MPOL_MF_STRICT is specified"), this commit
> > > also restored the oldest behavior (break loop early). But it also
> > > breaks the loop early when MPOL_MF_MOVE|MOVEALL is set, kernel should
> > > actually continue the loop to try to migrate all existing pages per
> > > the manual.
> >
> > Oh, I missed that aspect in my description: yes, I think that's the
> > worst of it: MPOL_MF_STRICT alone could break out early because it had
> > nothing more to learn by going further, but it was simply a mistake for
> > the MOVEs to break out early (and arguable what MOVE|STRICT should do).
> >
> > I thought you and I were going to have a debate about this, but we
> > appear to be in agreement.  And I'm not sure whether I agree with
> > myself about whether do_mbind() should apply the mbind_range()s
> > when STRICT queue_pages_range() found an unmovable - there are
> > consistency and regression arguments both ways.
>=20
> They will not be added into the migration list in the first place. Why
> waste time to try to migrate the unmovable?

I don't understand you there.  I was not proposing to try to migrate
the unmovable.

My doubts were really all about how to make sense of mbind() sometimes
failing with EFAULT, in which case it has not applied the mbind_range()s,
versus sometimes failing with EIO, in which case it may or may not have
applied the mbind_range()s.

And I've come to the conclusion (partially driven by precedent) that it
makes best sense to imagine the collection of folios on pagelist as a
part of MOVE's migration stage, and just an implementation detail that
it happens to be done before the mbind_range()s.  So when there's a
MOVE involved, STRICT's EIO says that the mbind_ranges() were applied
(but migrations were incomplete); but when no MOVE involved, EIO says
that the mbind_range()s were not applied (because it's being STRICT).

I don't think there's any disagreement between us on this: it was just
hard for me to reach an understanding of behavior which I could defend.

>=20
> >
> > (I've been repeatedly puzzled by your comment in queue_folios_pte_range=
()
> >                 if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> >                         /* MPOL_MF_STRICT must be specified if we get h=
ere */
> >                         if (!vma_migratable(vma)) {
> > Does that commment about MPOL_MF_STRICT actually belong inside the
> > !vma_migratable(vma) block?  Sometimes I think so, but sometimes I
> > remember that the interaction of those flags, and the skipping arranged
> > by queue_pages_test_walk(), is subtler than I imagine.)
>=20
> It is because the below code snippet from queue_pages_test_walk():
>=20
> if (!vma_migratable(vma) &&
>     !(flags & MPOL_MF_STRICT))
> return 1;
>=20
> When queue_pages_test_walk() returns 1, queue_folios_pte_range() will
> be skipped. So if queue_folios_pte_range() sees unmigratable vma, it
> means MPOL_MF_STRICT must be set.

Thanks, yes, I eventually came to see that, once I got back into the code
(I had been right to remember "subtler than I imagine" above).  Though I
don't think there's any good reason for the queueing code to have to
depend on such subtleties.

>=20
> >
> > > It sounds like a regression. I will take a look at it.

At one point I was thinking it a regression in all the MOVE cases;
but it's only in the STRICT MOVE case, so maybe not so significant.

> >
> > Thanks! Please do, I don't have the time for it.

I came back in private mail to say that I'd not managed a buildable
v5.2 version of my qp->nr_failed patch, so reluctantly put in the time
to think through it all again, and do a v6.6-rc1 version to add into my
mm/mempolicy series.

I have that now, I'll send you the preview privately in a moment; but
leave posting it publicly until I've finished the commit messages for
all the series.

> >
> > >
> > > So the logic should conceptually look like:
> > >
> > > if (MPOL_MF_MOVE|MOVEALL)
> > >     continue;
> > > if (MPOL_MF_STRICT)
> > >     break;
> > >
> > > So it is still possible that some VMAs are not locked if only
> > > MPOL_MF_STRICT is set.
> >
> > Conditionally, I'll agree; but it's too easy for me to agree in the
> > course of trying to get an email out, but on later reflection come
> > to disagree.  STRICT|MOVE behavior arguable.
>=20
> I thought the code should conceptually do:
>=20
> if (MPOL_MF_MOVE|MOVEALL)
>     scan all vmas
>     try to migrate the existing pages
>     return success
> else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
>     scan all vmas
>     try to migrate the existing pages
>     return -EIO if unmovable or migration failed
> else /* MPOL_MF_STRICT alone */
>     break early if meets unmovable and don't call mbind_range() at all
else /* none of those flags */
      check the ranges in test_walk, EFAULT without mbind_range() if discon=
tig.

Yes: to quote my own patch:
static bool strictly_unmovable(unsigned long flags)
{
=09/*
=09 * STRICT without MOVE flags lets do_mbind() fail immediately with -EIO
=09 * if any misplaced page is found.
=09 */
=09return (flags & (MPOL_MF_STRICT | MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) =3D=
=3D
=09=09=09 MPOL_MF_STRICT;
}

>=20
> So the vma scan will just be skipped when MPOL_MF_STRICT alone is
> specified and mbind_range() won't be called in this case. So Suren's
> fix may not be needed.

Yes, Suren's fix can be reverted when your patch or mine goes in;
but Suren's is important for fixing the VMA locking issue meanwhile.

>=20
> >
> > I think the best I can do is send you (privately) my approx-v5.2 patch
> > for this (which I never got time to put into even a Google-internal
> > kernel, though an earlier version was there).  In part because I did
> > more research back then, and its commit message cites several even
> > older commits than you cite above, which might help to shed more light
> > on the history (or might just be wrong).  And in part because it may
> > give you some more ideas of what needs doing: notably qp->nr_failed,
> > because "man 2 migrate_pages" says "On success migrate_pages() returns
> > the number of pages that could not be moved", but we seem to have
> > lost sight of that (from which one may conclude that it's not very
> > important, but I did find it useful when testing); but of course
> > the usual doubts about the right way to count a page when compound.
> >
> > I'll check how easily that patch applies to a known base such as
> > v5.2, maybe trim it to fit better, then send it off to you.
>=20
> I'm thinking about the below fix (build test against the latest
> mm-unstable only):

Yes, that looks about right (more "|=3D"ing than necessary, for something
that's only going to be set to 1, er, I think would better be "true").

And it's much smaller (rightly so if it's aimed at v6.6) than my patch
which is aimed at v6.7: mine doing quite a bit of cleanup, along with
the qp->nr_failed instead of your qp->has_unmovable, in order that
migrate_pages(2) can return the promised number of pages that could
not be moved.

Hugh

>=20
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..c9b768a042a8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -426,6 +426,7 @@ struct queue_pages {
>   unsigned long start;
>   unsigned long end;
>   struct vm_area_struct *first;
> + bool has_unmovable;
>  };
>=20
>  /*
> @@ -446,9 +447,8 @@ static inline bool queue_folio_required(struct folio =
*folio,
>  /*
>   * queue_folios_pmd() has three possible return values:
>   * 0 - folios are placed on the right node or queued successfully, or
> - *     special page is met, i.e. huge zero page.
> - * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
> + *     special page is met, i.e. zero page, or unmovable page is found
> + *     but continue walking (indicated by queue_pages.has_unmovable).
>   * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
>   *        existing folio was already on a node that does not follow the
>   *        policy.
> @@ -479,7 +479,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t
> *ptl, unsigned long addr,
>   if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>   if (!vma_migratable(walk->vma) ||
>       migrate_folio_add(folio, qp->pagelist, flags)) {
> - ret =3D 1;
> + qp->has_unmovable |=3D 1;
>   goto unlock;
>   }
>   } else
> @@ -495,9 +495,8 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t
> *ptl, unsigned long addr,
>   *
>   * queue_folios_pte_range() has three possible return values:
>   * 0 - folios are placed on the right node or queued successfully, or
> - *     special page is met, i.e. zero page.
> - * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
> + *     special page is met, i.e. zero page, or unmovable page is found
> + *     but continue walking (indicated by queue_pages.has_unmovable).
>   * -EIO - only MPOL_MF_STRICT was specified and an existing folio was al=
ready
>   *        on a node that does not follow the policy.
>   */
> @@ -538,10 +537,13 @@ static int queue_folios_pte_range(pmd_t *pmd,
> unsigned long addr,
>   if (!queue_folio_required(folio, qp))
>   continue;
>   if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> - /* MPOL_MF_STRICT must be specified if we get here */
> + /*
> + * MPOL_MF_STRICT must be specified if we get here.
> + * Continue walking vmas due to MPOL_MF_MOVE* flags.
> + */
>   if (!vma_migratable(vma)) {
> - has_unmovable =3D true;
> - break;
> + qp->has_unmovable |=3D 1;
> + continue;
>   }
>=20
>   /*
> @@ -550,16 +552,13 @@ static int queue_folios_pte_range(pmd_t *pmd,
> unsigned long addr,
>   * need migrate other LRU pages.
>   */
>   if (migrate_folio_add(folio, qp->pagelist, flags))
> - has_unmovable =3D true;
> + has_unmovable |=3D 1;
>   } else
>   break;
>   }
>   pte_unmap_unlock(mapped_pte, ptl);
>   cond_resched();
>=20
> - if (has_unmovable)
> - return 1;
> -
>   return addr !=3D end ? -EIO : 0;
>  }
>=20
> @@ -599,7 +598,7 @@ static int queue_folios_hugetlb(pte_t *pte,
> unsigned long hmask,
>   * Detecting misplaced folio but allow migrating folios which
>   * have been queued.
>   */
> - ret =3D 1;
> + qp->has_unmovable |=3D 1;
>   goto unlock;
>   }
>=20
> @@ -620,7 +619,7 @@ static int queue_folios_hugetlb(pte_t *pte,
> unsigned long hmask,
>   * Failed to isolate folio but allow migrating pages
>   * which have been queued.
>   */
> - ret =3D 1;
> + qp->has_unmovable |=3D 1;
>   }
>  unlock:
>   spin_unlock(ptl);
> @@ -756,12 +755,15 @@ queue_pages_range(struct mm_struct *mm, unsigned
> long start, unsigned long end,
>   .start =3D start,
>   .end =3D end,
>   .first =3D NULL,
> + .has_unmovable =3D false,
>   };
>   const struct mm_walk_ops *ops =3D lock_vma ?
>   &queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
>=20
>   err =3D walk_page_range(mm, start, end, ops, &qp);
>=20
> + if (qp.has_unmovable)
> + err =3D 1;
>   if (!qp.first)
>   /* whole range in hole */
>   err =3D -EFAULT;
> @@ -1358,7 +1360,7 @@ static long do_mbind(unsigned long start,
> unsigned long len,
>   putback_movable_pages(&pagelist);
>   }
>=20
> - if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
> + if (((ret > 0) || nr_failed) && (flags & MPOL_MF_STRICT))
>   err =3D -EIO;
>   } else {
>  up_out:
---1463760895-961474384-1695083654=:22034--
