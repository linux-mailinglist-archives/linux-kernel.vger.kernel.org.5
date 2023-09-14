Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5750C7A0F59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjINUyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjINUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:54:17 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104E1BEF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:54:13 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c92a2c52dso15646837b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694724853; x=1695329653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKqdJpEhXaeQzQWCZBTpv9uWAL/fOLXY3yRJZGmhuG4=;
        b=UsoH84UakKh1w0iRggqwt52thpyelaHQldRQGUWWB/r+qKyFeBjovW+00jurBoXZcH
         DjTKjBFLugfOIbOG1xpRu5WqdMgi7HI23IzAgBi0SPYE1wR64SywnwAutgXiNcFRQLnH
         NGFd/hz8osZnpyseMp82kEHJKSxrngEupGeSrPR2mBViG7TVzxgJtFev1DXiV4r663ja
         IGqD/LwTXG0L5DWj91AwULcwEaUXcmy6hcS7w5CYhI9qY6tqVv30OlCGHvvMJw8Bjr4V
         wwifs/IOjYlev6kd6qw7WUHXcf8WH4hB6qauPloUMkXcr2t1ylUzsyw+r5qlTqJT5dte
         fLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724853; x=1695329653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKqdJpEhXaeQzQWCZBTpv9uWAL/fOLXY3yRJZGmhuG4=;
        b=VhL98JUrE0NFR99LYCsPm5J2DOfObY0F3P7EQBMBflOq5WeqMd3nbCWGp47M/R95Yr
         odEGq445xaZ9GFqJHmI0QokmaAD0rXFPrHCpDAEumrWCKMWdISKz7di2OzIbG4XXUCWQ
         rkafFutuOqr6hdJ0SFSxfGXu2XDneaYP1drl0AbvA4JtG4Ng7btC/ilHwd5izD/zzAuc
         cWK52WQUQalWynINZ3Vd/5+8LfyvidVtMsNzTtkB6f0dmaUF6EelWKO+6P3N/mbeWeph
         w/UWdPYnXWKqjF9ACITnPp4Erq/MKDUd3s8iMbGhj/i7BuS2ugjDn0FK4GqzyNboyZJS
         xRtg==
X-Gm-Message-State: AOJu0Yyz/M8az2wOkMQLw0f7kG3TkR1UeF4+RkSlouLdAjsIBmzhLj5N
        wWt17QlUqguz+Ul7RCE2G5DzVcWxkRhHQe9kLjZ76gtTuSxg6kabtiCReA==
X-Google-Smtp-Source: AGHT+IF4DvWD3xJkF2IOcbdqofMhRhruqJm2atUAe2XDNeL27MYzjsKYmgYMjt6xJog9bazLiMekC3zpQjze/QrotIY=
X-Received: by 2002:a0d:ca97:0:b0:59b:d351:60cd with SMTP id
 m145-20020a0dca97000000b0059bd35160cdmr5897145ywd.38.1694724852506; Thu, 14
 Sep 2023 13:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f392a60604a65085@google.com> <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
 <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
 <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
 <ZQNaT/3xPxATKJVR@casper.infradead.org> <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com>
In-Reply-To: <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 20:53:59 +0000
Message-ID: <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 8:00=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Sep 14, 2023 at 7:09=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan wrote:
> > > I think I found the problem and the explanation is much simpler. Whil=
e
> > > walking the page range, queue_folios_pte_range() encounters an
> > > unmovable page and queue_folios_pte_range() returns 1. That causes a
> > > break from the loop inside walk_page_range() and no more VMAs get
> > > locked. After that the loop calling mbind_range() walks over all VMAs=
,
> > > even the ones which were skipped by queue_folios_pte_range() and that
> > > causes this BUG assertion.
> > >
> > > Thinking what's the right way to handle this situation (what's the
> > > expected behavior here)...
> > > I think the safest way would be to modify walk_page_range() and make
> > > it continue calling process_vma_walk_lock() for all VMAs in the range
> > > even when __walk_page_range() returns a positive err. Any objection o=
r
> > > alternative suggestions?
> >
> > So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT were
> > specified.  That means we're going to return an error, no matter what,
> > and there's no point in calling mbind_range().  Right?
> >
> > +++ b/mm/mempolicy.c
> > @@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long start, unsigne=
d long len,
> >         ret =3D queue_pages_range(mm, start, end, nmask,
> >                           flags | MPOL_MF_INVERT, &pagelist, true);
> >
> > +       if (ret =3D=3D 1)
> > +               ret =3D -EIO;
> >         if (ret < 0) {
> >                 err =3D ret;
> >                 goto up_out;
> >
> > (I don't really understand this code, so it can't be this simple, can
> > it?  Why don't we just return -EIO from queue_folios_pte_range() if
> > this is the right answer?)
>
> Yeah, I'm trying to understand the expected behavior of this function
> to make sure we are not missing anything. I tried a simple fix that I
> suggested in my previous email and it works but I want to understand a
> bit more about this function's logic before posting the fix.

So, current functionality is that after queue_pages_range() encounters
an unmovable page, terminates the loop and returns 1, mbind_range()
will still be called for the whole range
(https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1345),
all pages in the pagelist will be migrated
(https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1355)
and only after that the -EIO code will be returned
(https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1362).
So, if we follow Matthew's suggestion we will be altering the current
behavior which I assume is not what we want to do.
The simple fix I was thinking about that would not alter this behavior
is smth like this:

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index b7d7e4fcfad7..c37a7e8be4cb 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -493,11 +493,17 @@ int walk_page_range(struct mm_struct *mm,
unsigned long start,
                 if (!vma) { /* after the last vma */
                         walk.vma =3D NULL;
                         next =3D end;
+                        if (err)
+                                continue;
+
                         if (ops->pte_hole)
                                 err =3D ops->pte_hole(start, next, -1, &wa=
lk);
                 } else if (start < vma->vm_start) { /* outside vma */
                         walk.vma =3D NULL;
                         next =3D min(end, vma->vm_start);
+                        if (err)
+                                continue;
+
                         if (ops->pte_hole)
                                 err =3D ops->pte_hole(start, next, -1, &wa=
lk);
                 } else { /* inside vma */
@@ -505,6 +511,8 @@ int walk_page_range(struct mm_struct *mm, unsigned
long start,
                         walk.vma =3D vma;
                         next =3D min(end, vma->vm_end);
                         vma =3D find_vma(mm, vma->vm_end);
+                        if (err)
+                                continue;

                         err =3D walk_page_test(start, next, &walk);
                         if (err > 0) {
@@ -520,8 +528,6 @@ int walk_page_range(struct mm_struct *mm, unsigned
long start,
                                 break;
                         err =3D __walk_page_range(start, next, &walk);
                 }
-                if (err)
-                        break;
         } while (start =3D next, start < end);
         return err;
 }

WDYT?
