Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F767A2D13
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbjIPBff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbjIPBfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:35:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13FCC1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:35:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26f4bc74131so1996524a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694828117; x=1695432917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDP8MuAzIXg6IFVmOdjNhHZQ4nVgpXiGwm/XOpBUoIo=;
        b=gqvFcy6ciuprAQdwJIIyS12pT5oh2ocGnWfjK/jhnYCRVWLMaGNJAzq/Prtj5nK9il
         EqhLCcfWY5J3oWTtdoLarriltjj/osqqOj3AHEwkBqIUbderHOSTqqo2R1VRldfUxPne
         B3FvHNOL7+yIJBW74ucphUoqJ7yuzpDn01U8TG+AWlXyHOWfuFD2zs+0AKrKrHJjuHuI
         R3MA0e0HLSFR4ugK/qstv+K488D8PhrBCbdz0DsFnVkFoz9zIswPciMB3IL4qB/oRKKd
         S1x+PaIooTy4Jync1B4u41aiaAWysWZlwaehucXHisUG8qSnIBJPpYbE4D11OxQkU3UE
         Snxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694828117; x=1695432917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDP8MuAzIXg6IFVmOdjNhHZQ4nVgpXiGwm/XOpBUoIo=;
        b=uHnmTzs5KhiY7+b2tiRpeiiHoKXrZj5FWLENcpDdI/wX8HCbz0FtCe3OoJNPJTNRaK
         dt5lV1PPqI0a2x3YL2+gevHCnOi67ZV1P7/AX9Z62mmUpoPjVBVtYk3w/C8q2GULqkD/
         M5RXliRURP83dYn7+aI0LdXwW8h1Skase3nCkB4GSZS+qUdfONMTbWny+pLcGgK7sIK0
         HKCax/g+2uHPbnzRjVmI+2CrRcN43wKtJGJd2VDlh3B6pr9LVa9mByQRMgAYNNK5lzl+
         U1c0mxs/Np2Hp8zONhrGxOpHHy3fQISOsw6cwqqeFP883lARSX7XljHwgvFEXexnHBeu
         bsRw==
X-Gm-Message-State: AOJu0YxuvWOzFeal3QtXrFbfiO5AtoPVFA3FRYU+JfYz7xnKT/8FrAF8
        UGuLt0PKRsR2oHPS7GKAnveV3MS3b4QZhKZSOsE=
X-Google-Smtp-Source: AGHT+IGRmqsdgkpiCbQ+4EDo0CWbFWhEUlnOxk+Sw/4Xj1QOSuG9/tPxvlknACsF0eai5kU6/zaF2DpKeDy/eu8gO44=
X-Received: by 2002:a17:90a:bc82:b0:274:9121:382 with SMTP id
 x2-20020a17090abc8200b0027491210382mr5337411pjr.22.1694828116763; Fri, 15 Sep
 2023 18:35:16 -0700 (PDT)
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
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com>
In-Reply-To: <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 15 Sep 2023 18:35:04 -0700
Message-ID: <CAHbLzkrmTaqBRmHVdE2kyW57Uoghqd_E+jAXC9cB5ofkhL-uvw@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 9:26=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Thu, 14 Sep 2023, Suren Baghdasaryan wrote:
> > On Thu, Sep 14, 2023 at 9:24=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > On Thu, Sep 14, 2023 at 08:53:59PM +0000, Suren Baghdasaryan wrote:
> > > > On Thu, Sep 14, 2023 at 8:00=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > > On Thu, Sep 14, 2023 at 7:09=E2=80=AFPM Matthew Wilcox <willy@inf=
radead.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan wr=
ote:
> > > > > > > I think I found the problem and the explanation is much simpl=
er. While
> > > > > > > walking the page range, queue_folios_pte_range() encounters a=
n
> > > > > > > unmovable page and queue_folios_pte_range() returns 1. That c=
auses a
> > > > > > > break from the loop inside walk_page_range() and no more VMAs=
 get
> > > > > > > locked. After that the loop calling mbind_range() walks over =
all VMAs,
> > > > > > > even the ones which were skipped by queue_folios_pte_range() =
and that
> > > > > > > causes this BUG assertion.
> > > > > > >
> > > > > > > Thinking what's the right way to handle this situation (what'=
s the
> > > > > > > expected behavior here)...
> > > > > > > I think the safest way would be to modify walk_page_range() a=
nd make
> > > > > > > it continue calling process_vma_walk_lock() for all VMAs in t=
he range
> > > > > > > even when __walk_page_range() returns a positive err. Any obj=
ection or
> > > > > > > alternative suggestions?
> > > > > >
> > > > > > So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT were
> > > > > > specified.  That means we're going to return an error, no matte=
r what,
> > > > > > and there's no point in calling mbind_range().  Right?
> > > > > >
> > > > > > +++ b/mm/mempolicy.c
> > > > > > @@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long start,=
 unsigned long len,
> > > > > >         ret =3D queue_pages_range(mm, start, end, nmask,
> > > > > >                           flags | MPOL_MF_INVERT, &pagelist, tr=
ue);
> > > > > >
> > > > > > +       if (ret =3D=3D 1)
> > > > > > +               ret =3D -EIO;
> > > > > >         if (ret < 0) {
> > > > > >                 err =3D ret;
> > > > > >                 goto up_out;
> > > > > >
> > > > > > (I don't really understand this code, so it can't be this simpl=
e, can
> > > > > > it?  Why don't we just return -EIO from queue_folios_pte_range(=
) if
> > > > > > this is the right answer?)
> > > > >
> > > > > Yeah, I'm trying to understand the expected behavior of this func=
tion
> > > > > to make sure we are not missing anything. I tried a simple fix th=
at I
> > > > > suggested in my previous email and it works but I want to underst=
and a
> > > > > bit more about this function's logic before posting the fix.
> > > >
> > > > So, current functionality is that after queue_pages_range() encount=
ers
> > > > an unmovable page, terminates the loop and returns 1, mbind_range()
> > > > will still be called for the whole range
> > > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L134=
5),
> > > > all pages in the pagelist will be migrated
> > > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L135=
5)
> > > > and only after that the -EIO code will be returned
> > > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L136=
2).
> > > > So, if we follow Matthew's suggestion we will be altering the curre=
nt
> > > > behavior which I assume is not what we want to do.
> > >
> > > Right, I'm intentionally changing the behaviour.  My thinking is
> > > that mbind(MPOL_MF_MOVE | MPOL_MF_STRICT) is going to fail.  Should
> > > such a failure actually move the movable pages before reporting that
> > > it failed?  I don't know.
> > >
> > > > The simple fix I was thinking about that would not alter this behav=
ior
> > > > is smth like this:
> > >
> > > I don't like it, but can we run it past syzbot to be sure it solves t=
he
> > > issue and we're not chasing a ghost here?
> >
> > Yes, I just finished running the reproducer on both upstream and
> > linux-next builds listed in
> > https://syzkaller.appspot.com/bug?extid=3Db591856e0f0139f83023 and the
> > problem does not happen anymore.
> > I'm fine with your suggestion too, just wanted to point out it would
> > introduce change in the behavior. Let me know how you want to proceed.
>
> Well done, identifying the mysterious cause of this problem:
> I'm glad to hear that you've now verified that hypothesis.
>
> You're right, it would be a regression to follow Matthew's suggestion.
>
> Traditionally, modulo bugs and inconsistencies, the queue_pages_range()
> phase of do_mbind() has done the best it can, gathering all the pages it
> can that need migration, even if some were missed; and proceeds to do the
> mbind_range() phase if there was nothing "seriously" wrong (a gap causing
> -EFAULT).  Then at the end, if MPOL_MF_STRICT was set, and not all the
> pages could be migrated (or MOVE was not specified and not all pages
> were well placed), it returns -EIO rather than 0 to inform the caller
> that not all could be done.
>
> There have been numerous tweaks, but I think most importantly
> 5.3's d883544515aa ("mm: mempolicy: make the behavior consistent when
> MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") added those "return 1"s
> which stop the pagewalk early.  In my opinion, not an improvement - makes
> it harder to get mbind() to do the best job it can (or is it justified as
> what you're asking for if you say STRICT?).

Hi Suren and Hugh,

Thanks for figuring this out. The mbind behavior is a little bit messy
and hard to follow. I tried my best to recall all the changes.

IIUC, mbind did break the vma iteration early in the first place, then
commit 6f4576e3687b ("mempolicy: apply page table walker on
queue_pages_range()") changed the behavior (didn't break vma iteration
early for some cases anymore), but it messed up the return value and
caused some test cases failure, also violated the manual. The return
value issue was fixed by commit a7f40cfe3b7a ("mm: mempolicy: make
mbind() return -EIO when MPOL_MF_STRICT is specified"), this commit
also restored the oldest behavior (break loop early). But it also
breaks the loop early when MPOL_MF_MOVE|MOVEALL is set, kernel should
actually continue the loop to try to migrate all existing pages per
the manual. It sounds like a regression. I will take a look at it.

So the logic should conceptually look like:

if (MPOL_MF_MOVE|MOVEALL)
    continue;
if (MPOL_MF_STRICT)
    break;

So it is still possible that some VMAs are not locked if only
MPOL_MF_STRICT is set.

>
> But whatever, it would be a further regression for mbind() not to have
> done the mbind_range(), even though it goes on to return -EIO.
>
> I had a bad first reaction to your walk_page_range() patch (was expecting
> to see vma_start_write()s in mbind_range()), but perhaps your patch is
> exactly what process_mm_walk_lock() does now demand.
>
> [Why is Hugh responding on this?  Because I have some long-standing
> mm/mempolicy.c patches to submit next week, but in reviewing what I
> could or could not afford to get into at this time, had decided I'd
> better stay out of queue_pages_range() for now - beyond the trivial
> preferring an MPOL_MF_WRLOCK flag to your bool lock_vma.]
>
> Hugh
