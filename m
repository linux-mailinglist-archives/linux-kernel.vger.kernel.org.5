Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C67A2553
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjIOSGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIOSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:05:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE119A9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:05:28 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7f0048b042so2381325276.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694801128; x=1695405928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrVfTWvidw6KIt1gA6gh98z08bQkOzyYMa1Hz/6HT9c=;
        b=CF8VeQ9Jm+5/Hg9xRjn0jTy1K/ahbMQwy3Vs7ggdNnf70oP6SNglCPddeDK9VM98so
         ETDrGPbpax/RIUnMlIoyNKM+oapgR4fswHu2Ofb8J/pNX+UkJMUhHYAUaZIUVM8AFypM
         3b/lLeCT3661DKXl5YLSdMzT6BlqKuNVk8WTuNmQBLvpb+CCb5lrt1giD48zEWUCneIF
         WhPDx/gZa4EIVNTSk/nbpz3FOOHPK0I8sN6NHMsc2oqq4Uy4P+qTORU7U8oK59USxDOp
         vCGlcEsZo/wCmRwqLwrkMKfRalsUlEa7qRgTtfyg112Lsu4SFCFD5PC2eyVpdkdTGZTD
         9gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694801128; x=1695405928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrVfTWvidw6KIt1gA6gh98z08bQkOzyYMa1Hz/6HT9c=;
        b=U8jUO3NLBr6sGTZPRfKBamfaV8ZN+hmmfQZwyCHnYo6v7pxNE4saAu2P18vUdDSVZd
         NrrV0Kj9inkSrkRetrs18sLUeQH3/8RIKEI9Rvqwt0tbLtFA2cYPZm8kJ54WK7ZE4bKJ
         s9+YlwYLcNO/JGFqwtSVv2vVnDv//dNYLE0b0CToe9y1xlXYekSC7a58dN5L2Fv9VsrK
         P9stV91A/hnG4IrnbiRzdrh5sHo8qIA9FEzLrPBeRNj6LOnXH6iB9iQnfkQsEkPPEDbK
         gr7Z/eHDo/5ZnWYgGuTo+ZwyID6n0Kv3UICkH1hC/L6QJAOzrHp/lsOU7/RB3AM7Dp9c
         u74g==
X-Gm-Message-State: AOJu0YxGNQNj6/dxf8Km9ANmJ/o84aP6Z5qkjawt7WdK9045yoo0B5Xf
        ir82S02LRKsxdLOjkmrVIYsFc/NACOpO2N/qsgiDSQ==
X-Google-Smtp-Source: AGHT+IHIzOSnTpyS/wBQYEDRFq2qubMTYkQRKYEhlL9Wpr7/okybozOUQjxdwG8vSx1FNBDnxPmLRCuCS92UNxj2PSE=
X-Received: by 2002:a25:cb8b:0:b0:d81:5ec1:80d5 with SMTP id
 b133-20020a25cb8b000000b00d815ec180d5mr2573293ybg.18.1694801127773; Fri, 15
 Sep 2023 11:05:27 -0700 (PDT)
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
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com> <CAJuCfpGO4bRZaDJv5Vuf2wLh3t4hE=5EqDObm_UfcQk4B08PrQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGO4bRZaDJv5Vuf2wLh3t4hE=5EqDObm_UfcQk4B08PrQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 15 Sep 2023 11:05:14 -0700
Message-ID: <CAJuCfpE8jnvL23W6fY4_HZf-969aEgvR3-LGRTUC-SFhPFju+w@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 15, 2023 at 9:09=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Sep 14, 2023 at 9:26=E2=80=AFPM Hugh Dickins <hughd@google.com> w=
rote:
> >
> > On Thu, 14 Sep 2023, Suren Baghdasaryan wrote:
> > > On Thu, Sep 14, 2023 at 9:24=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > > On Thu, Sep 14, 2023 at 08:53:59PM +0000, Suren Baghdasaryan wrote:
> > > > > On Thu, Sep 14, 2023 at 8:00=E2=80=AFPM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > > > > On Thu, Sep 14, 2023 at 7:09=E2=80=AFPM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan =
wrote:
> > > > > > > > I think I found the problem and the explanation is much sim=
pler. While
> > > > > > > > walking the page range, queue_folios_pte_range() encounters=
 an
> > > > > > > > unmovable page and queue_folios_pte_range() returns 1. That=
 causes a
> > > > > > > > break from the loop inside walk_page_range() and no more VM=
As get
> > > > > > > > locked. After that the loop calling mbind_range() walks ove=
r all VMAs,
> > > > > > > > even the ones which were skipped by queue_folios_pte_range(=
) and that
> > > > > > > > causes this BUG assertion.
> > > > > > > >
> > > > > > > > Thinking what's the right way to handle this situation (wha=
t's the
> > > > > > > > expected behavior here)...
> > > > > > > > I think the safest way would be to modify walk_page_range()=
 and make
> > > > > > > > it continue calling process_vma_walk_lock() for all VMAs in=
 the range
> > > > > > > > even when __walk_page_range() returns a positive err. Any o=
bjection or
> > > > > > > > alternative suggestions?
> > > > > > >
> > > > > > > So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT we=
re
> > > > > > > specified.  That means we're going to return an error, no mat=
ter what,
> > > > > > > and there's no point in calling mbind_range().  Right?
> > > > > > >
> > > > > > > +++ b/mm/mempolicy.c
> > > > > > > @@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long star=
t, unsigned long len,
> > > > > > >         ret =3D queue_pages_range(mm, start, end, nmask,
> > > > > > >                           flags | MPOL_MF_INVERT, &pagelist, =
true);
> > > > > > >
> > > > > > > +       if (ret =3D=3D 1)
> > > > > > > +               ret =3D -EIO;
> > > > > > >         if (ret < 0) {
> > > > > > >                 err =3D ret;
> > > > > > >                 goto up_out;
> > > > > > >
> > > > > > > (I don't really understand this code, so it can't be this sim=
ple, can
> > > > > > > it?  Why don't we just return -EIO from queue_folios_pte_rang=
e() if
> > > > > > > this is the right answer?)
> > > > > >
> > > > > > Yeah, I'm trying to understand the expected behavior of this fu=
nction
> > > > > > to make sure we are not missing anything. I tried a simple fix =
that I
> > > > > > suggested in my previous email and it works but I want to under=
stand a
> > > > > > bit more about this function's logic before posting the fix.
> > > > >
> > > > > So, current functionality is that after queue_pages_range() encou=
nters
> > > > > an unmovable page, terminates the loop and returns 1, mbind_range=
()
> > > > > will still be called for the whole range
> > > > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1=
345),
> > > > > all pages in the pagelist will be migrated
> > > > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1=
355)
> > > > > and only after that the -EIO code will be returned
> > > > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1=
362).
> > > > > So, if we follow Matthew's suggestion we will be altering the cur=
rent
> > > > > behavior which I assume is not what we want to do.
> > > >
> > > > Right, I'm intentionally changing the behaviour.  My thinking is
> > > > that mbind(MPOL_MF_MOVE | MPOL_MF_STRICT) is going to fail.  Should
> > > > such a failure actually move the movable pages before reporting tha=
t
> > > > it failed?  I don't know.
> > > >
> > > > > The simple fix I was thinking about that would not alter this beh=
avior
> > > > > is smth like this:
> > > >
> > > > I don't like it, but can we run it past syzbot to be sure it solves=
 the
> > > > issue and we're not chasing a ghost here?
> > >
> > > Yes, I just finished running the reproducer on both upstream and
> > > linux-next builds listed in
> > > https://syzkaller.appspot.com/bug?extid=3Db591856e0f0139f83023 and th=
e
> > > problem does not happen anymore.
> > > I'm fine with your suggestion too, just wanted to point out it would
> > > introduce change in the behavior. Let me know how you want to proceed=
.
> >
> > Well done, identifying the mysterious cause of this problem:
> > I'm glad to hear that you've now verified that hypothesis.
> >
> > You're right, it would be a regression to follow Matthew's suggestion.
> >
> > Traditionally, modulo bugs and inconsistencies, the queue_pages_range()
> > phase of do_mbind() has done the best it can, gathering all the pages i=
t
> > can that need migration, even if some were missed; and proceeds to do t=
he
> > mbind_range() phase if there was nothing "seriously" wrong (a gap causi=
ng
> > -EFAULT).  Then at the end, if MPOL_MF_STRICT was set, and not all the
> > pages could be migrated (or MOVE was not specified and not all pages
> > were well placed), it returns -EIO rather than 0 to inform the caller
> > that not all could be done.
> >
> > There have been numerous tweaks, but I think most importantly
> > 5.3's d883544515aa ("mm: mempolicy: make the behavior consistent when
> > MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") added those "return 1=
"s
> > which stop the pagewalk early.  In my opinion, not an improvement - mak=
es
> > it harder to get mbind() to do the best job it can (or is it justified =
as
> > what you're asking for if you say STRICT?).
> >
> > But whatever, it would be a further regression for mbind() not to have
> > done the mbind_range(), even though it goes on to return -EIO.
> >
> > I had a bad first reaction to your walk_page_range() patch (was expecti=
ng
> > to see vma_start_write()s in mbind_range()), but perhaps your patch is
> > exactly what process_mm_walk_lock() does now demand.
> >
> > [Why is Hugh responding on this?  Because I have some long-standing
> > mm/mempolicy.c patches to submit next week, but in reviewing what I
> > could or could not afford to get into at this time, had decided I'd
> > better stay out of queue_pages_range() for now - beyond the trivial
> > preferring an MPOL_MF_WRLOCK flag to your bool lock_vma.]
>
> Thanks for the feedback, Hugh!
> Yeah, this positive err handling is kinda weird. If this behavior (do
> as much as possible even if we fail eventually) is specific to mbind()
> then we could keep walk_page_range() as is and lock the VMAs inside
> the loop that calls mbind_range() with a condition that ret is
> positive. That would be the simplest solution IMHO. But if we expect
> walk_page_range() to always apply requested page_walk_lock policy to
> all VMAs even if some mm_walk_ops returns a positive error somewhere
> in the middle of the walk then my fix would work for that. So, to me
> the important question is how we want walk_page_range() to behave in
> these conditions. I think we should answer that first and document
> that. Then the fix will be easy.

I looked at all the cases where we perform page walk while locking
VMAs and mbind() seems to be the only one that would require
walk_page_range() to lock all VMAs even for a failed walk. So, I
suggest this fix instead and I can also document that if
walk_page_range() fails it might not apply page_walk_lock policy to
the VMAs.

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..cbc584e9b6ca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1342,6 +1342,9 @@ static long do_mbind(unsigned long start,
unsigned long len,
         vma_iter_init(&vmi, mm, start);
         prev =3D vma_prev(&vmi);
         for_each_vma_range(vmi, vma, end) {
+                /* If queue_pages_range failed then not all VMAs
might be locked */
+                if (ret)
+                        vma_start_write(vma);
                 err =3D mbind_range(&vmi, vma, &prev, start, end, new);
                 if (err)
                         break;

If this looks good I'll post the patch. Matthew, Hugh, anyone else?

>
>
> >
> > Hugh
