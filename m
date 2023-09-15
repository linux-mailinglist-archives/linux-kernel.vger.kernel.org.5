Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544587A14C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjIOE0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOE0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:26:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE8270A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:26:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d818d4230f6so1497898276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694751990; x=1695356790; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qy1MWRDW/N7/7GaK+3ShmCxrItvLSys0pDTcIaDLgUo=;
        b=UNH1wm3pK+gGPli7RcNkvK9bsXqMOUS3IBRKRcBnQm6UHKPQNQ+f36zFD2lwjn5BPL
         sWh4dOAWT3k67dY2CxxA37YVD+oSHBWWUOW5uVMaIjds0PfvVvXzkrfXcLyktPTSxHwb
         2E1hFH9wAm9mX1haKVymK4vhanISX1aq+Ju8Sbr9Bs9XM67X/YXlX5SYa9QZAxUODIjN
         XWT56TsGwo9EJrpc5coNRSwV332TSOiwbkUwVRLfAwmft63UevSqkUU+OoeMuWjKJQIV
         iV8cq3Z32kVt8Cam5ystJ6bcyHJysCWoRO1lyUudnjBVKKl1g2zjF3M1PPNn9D6aDjKi
         Kakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694751990; x=1695356790;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy1MWRDW/N7/7GaK+3ShmCxrItvLSys0pDTcIaDLgUo=;
        b=FMfJKQRfjyqtHNVbnPw6XbZImxYn6hQoFEiZmwEsjzqGztp2KF6KghaOQEKf2Y0UC9
         44xPSwyU0pque0PddDm7W3WEn6AL7pxxmj2dASAST2jzWZfSmfgd5PC3MXjotIOaRkw7
         1pXCK1LibhnNSzevvzthB3nU5m5mdj/5YJAfsiMF0VKgtlev1y+SSLylbaktDxhWNeAu
         UTb97VibEIS3E6F53SRt/JN0L3jmBhjIikAO0qemZHQTzXbn8wck+oit7dz2pokry+LP
         EbEzQTJLTHNyn9H4dTgZvId7LS2WD9J/UV2W6JMGsbasmQiHHYvcHqol7pfZRAcDwu31
         04Aw==
X-Gm-Message-State: AOJu0YzpszsPx+e92OD9GUWqypwJt5cKuw/JF6vyV4wgNLBG0U3ehuDn
        XnNaO3nlEBK+QhaGogY/tFqvwg==
X-Google-Smtp-Source: AGHT+IH+lTkhfrC1mqknRA+Ma4UtmUqUdcdvECb/tWFAtNO7hi4x11c7xryrBjvUNqjdfSQnc3ibgw==
X-Received: by 2002:a25:8041:0:b0:d80:1023:8222 with SMTP id a1-20020a258041000000b00d8010238222mr447199ybn.34.1694751990205;
        Thu, 14 Sep 2023 21:26:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a23-20020a25ca17000000b00d7b957d8ed9sm682413ybg.17.2023.09.14.21.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:26:29 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:26:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Suren Baghdasaryan <surenb@google.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
In-Reply-To: <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
Message-ID: <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com>
References: <ZP/3hgDCXeceE9uU@casper.infradead.org> <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com> <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com> <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com> <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com> <ZQNaT/3xPxATKJVR@casper.infradead.org>
 <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com> <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com> <ZQN58hFWfgn+OfvG@casper.infradead.org> <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-522046950-1694751990=:12895"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-522046950-1694751990=:12895
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Sep 2023, Suren Baghdasaryan wrote:
> On Thu, Sep 14, 2023 at 9:24=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> > On Thu, Sep 14, 2023 at 08:53:59PM +0000, Suren Baghdasaryan wrote:
> > > On Thu, Sep 14, 2023 at 8:00=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > > On Thu, Sep 14, 2023 at 7:09=E2=80=AFPM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan wrot=
e:
> > > > > > I think I found the problem and the explanation is much simpler=
=2E While
> > > > > > walking the page range, queue_folios_pte_range() encounters an
> > > > > > unmovable page and queue_folios_pte_range() returns 1. That cau=
ses a
> > > > > > break from the loop inside walk_page_range() and no more VMAs g=
et
> > > > > > locked. After that the loop calling mbind_range() walks over al=
l VMAs,
> > > > > > even the ones which were skipped by queue_folios_pte_range() an=
d that
> > > > > > causes this BUG assertion.
> > > > > >
> > > > > > Thinking what's the right way to handle this situation (what's =
the
> > > > > > expected behavior here)...
> > > > > > I think the safest way would be to modify walk_page_range() and=
 make
> > > > > > it continue calling process_vma_walk_lock() for all VMAs in the=
 range
> > > > > > even when __walk_page_range() returns a positive err. Any objec=
tion or
> > > > > > alternative suggestions?
> > > > >
> > > > > So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT were
> > > > > specified.  That means we're going to return an error, no matter =
what,
> > > > > and there's no point in calling mbind_range().  Right?
> > > > >
> > > > > +++ b/mm/mempolicy.c
> > > > > @@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long start, u=
nsigned long len,
> > > > >         ret =3D queue_pages_range(mm, start, end, nmask,
> > > > >                           flags | MPOL_MF_INVERT, &pagelist, true=
);
> > > > >
> > > > > +       if (ret =3D=3D 1)
> > > > > +               ret =3D -EIO;
> > > > >         if (ret < 0) {
> > > > >                 err =3D ret;
> > > > >                 goto up_out;
> > > > >
> > > > > (I don't really understand this code, so it can't be this simple,=
 can
> > > > > it?  Why don't we just return -EIO from queue_folios_pte_range() =
if
> > > > > this is the right answer?)
> > > >
> > > > Yeah, I'm trying to understand the expected behavior of this functi=
on
> > > > to make sure we are not missing anything. I tried a simple fix that=
 I
> > > > suggested in my previous email and it works but I want to understan=
d a
> > > > bit more about this function's logic before posting the fix.
> > >
> > > So, current functionality is that after queue_pages_range() encounter=
s
> > > an unmovable page, terminates the loop and returns 1, mbind_range()
> > > will still be called for the whole range
> > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1345)=
,
> > > all pages in the pagelist will be migrated
> > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1355)
> > > and only after that the -EIO code will be returned
> > > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1362)=
=2E
> > > So, if we follow Matthew's suggestion we will be altering the current
> > > behavior which I assume is not what we want to do.
> >
> > Right, I'm intentionally changing the behaviour.  My thinking is
> > that mbind(MPOL_MF_MOVE | MPOL_MF_STRICT) is going to fail.  Should
> > such a failure actually move the movable pages before reporting that
> > it failed?  I don't know.
> >
> > > The simple fix I was thinking about that would not alter this behavio=
r
> > > is smth like this:
> >
> > I don't like it, but can we run it past syzbot to be sure it solves the
> > issue and we're not chasing a ghost here?
>=20
> Yes, I just finished running the reproducer on both upstream and
> linux-next builds listed in
> https://syzkaller.appspot.com/bug?extid=3Db591856e0f0139f83023 and the
> problem does not happen anymore.
> I'm fine with your suggestion too, just wanted to point out it would
> introduce change in the behavior. Let me know how you want to proceed.

Well done, identifying the mysterious cause of this problem:
I'm glad to hear that you've now verified that hypothesis.

You're right, it would be a regression to follow Matthew's suggestion.

Traditionally, modulo bugs and inconsistencies, the queue_pages_range()
phase of do_mbind() has done the best it can, gathering all the pages it
can that need migration, even if some were missed; and proceeds to do the
mbind_range() phase if there was nothing "seriously" wrong (a gap causing
-EFAULT).  Then at the end, if MPOL_MF_STRICT was set, and not all the
pages could be migrated (or MOVE was not specified and not all pages
were well placed), it returns -EIO rather than 0 to inform the caller
that not all could be done.

There have been numerous tweaks, but I think most importantly
5.3's d883544515aa ("mm: mempolicy: make the behavior consistent when
MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") added those "return 1"s
which stop the pagewalk early.  In my opinion, not an improvement - makes
it harder to get mbind() to do the best job it can (or is it justified as
what you're asking for if you say STRICT?).

But whatever, it would be a further regression for mbind() not to have
done the mbind_range(), even though it goes on to return -EIO.

I had a bad first reaction to your walk_page_range() patch (was expecting
to see vma_start_write()s in mbind_range()), but perhaps your patch is
exactly what process_mm_walk_lock() does now demand.

[Why is Hugh responding on this?  Because I have some long-standing
mm/mempolicy.c patches to submit next week, but in reviewing what I
could or could not afford to get into at this time, had decided I'd
better stay out of queue_pages_range() for now - beyond the trivial
preferring an MPOL_MF_WRLOCK flag to your bool lock_vma.]

Hugh
--8323328-522046950-1694751990=:12895--
