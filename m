Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC567A10DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjINWV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:21:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B3F26A4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:21:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so1338345f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694730083; x=1695334883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGIMEgSkXCbpKrdkhs9f3Eb1IgGXBmukqlPzTkm6Mos=;
        b=Ul0ZkcgXlqIwQXmzVBDGLxy6xF6e6QQozo7eD9klO4zu7nvCs+1892sVotwJLGRT2Y
         bJHg4WO0dkCDp3o1X2syuHcAuXOctZnFJU9yYPpaqSVIU3NL+29EmRhEl5qH3Iw0qu8J
         P6nj+nwaq3u0Pcu/yy70zWHM0dSIO1OUl36sPk3ebkyure9E05z0jvMNScDczXxuSGxl
         xvhMP5lzCorL9HdWJ77VSM53T+QKcDkwcvlZKCUI/udAti09Z0mOTPwBsmMpzojmPirQ
         dmLj9LKCVi2SEGOo7eq996WR6vmUuQCv+pQiK0PRDEwdKxKeM+V4c/dk4UaiyJtynqhX
         18zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730083; x=1695334883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGIMEgSkXCbpKrdkhs9f3Eb1IgGXBmukqlPzTkm6Mos=;
        b=mLZYWxx3hz7tz7BGFRjnwEMdu0GMKnmWGy5IMpkFuGC8RELy0vTDpxdm9ZvP9PNmgJ
         6hPwHM0BwhjUQ/GwSvgsOF9poi00OKkHnoPq55RfiEVdZ8mUdyN3RYwaXpmuEVscH0CA
         H2TsEQyvWRpmLF/Kt6/uxEekGIl/mRU2511n7ugucjgfDuWVcwMzTXwtLMTkOGja5uTG
         /Stj7e/U1q3NcIZFLNyDaB+ZgqM1RaqD+zpybhZkJlYwOZEsvYpTdV9RRJY6p9RWVg32
         WpSTFy0XQDZDDfGH/ObgwJzVAEZafL6K3jLomgOYLPJvZKiwposaYqQYGz7u5b9JAXtD
         /lIw==
X-Gm-Message-State: AOJu0YyNFZXBZ8lxXvcHUg2QN0HQviJso6roW1sPOtR/yr7ji9p/C/bZ
        zid/ddhjncDu3lHGL4obbg3QyJ/6zksV7EOw5pT+Dg==
X-Google-Smtp-Source: AGHT+IFXfO54+GQkZBkZJgXD7yb35OdK0sQJ/G4kr2enWyYfxtN7RtNgtMfAKsWMs6I+us0ETZORF/wNcFn+NZVe8MY=
X-Received: by 2002:a5d:5387:0:b0:317:731a:6702 with SMTP id
 d7-20020a5d5387000000b00317731a6702mr5546547wrv.19.1694730082641; Thu, 14 Sep
 2023 15:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZP/3hgDCXeceE9uU@casper.infradead.org> <ZQB76G/6NxVgoE9u@casper.infradead.org>
 <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
 <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
 <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
 <ZQNaT/3xPxATKJVR@casper.infradead.org> <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com>
 <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com> <ZQN58hFWfgn+OfvG@casper.infradead.org>
In-Reply-To: <ZQN58hFWfgn+OfvG@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 22:21:07 +0000
Message-ID: <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
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

On Thu, Sep 14, 2023 at 9:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Sep 14, 2023 at 08:53:59PM +0000, Suren Baghdasaryan wrote:
> > On Thu, Sep 14, 2023 at 8:00=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 7:09=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan wrote:
> > > > > I think I found the problem and the explanation is much simpler. =
While
> > > > > walking the page range, queue_folios_pte_range() encounters an
> > > > > unmovable page and queue_folios_pte_range() returns 1. That cause=
s a
> > > > > break from the loop inside walk_page_range() and no more VMAs get
> > > > > locked. After that the loop calling mbind_range() walks over all =
VMAs,
> > > > > even the ones which were skipped by queue_folios_pte_range() and =
that
> > > > > causes this BUG assertion.
> > > > >
> > > > > Thinking what's the right way to handle this situation (what's th=
e
> > > > > expected behavior here)...
> > > > > I think the safest way would be to modify walk_page_range() and m=
ake
> > > > > it continue calling process_vma_walk_lock() for all VMAs in the r=
ange
> > > > > even when __walk_page_range() returns a positive err. Any objecti=
on or
> > > > > alternative suggestions?
> > > >
> > > > So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT were
> > > > specified.  That means we're going to return an error, no matter wh=
at,
> > > > and there's no point in calling mbind_range().  Right?
> > > >
> > > > +++ b/mm/mempolicy.c
> > > > @@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long start, uns=
igned long len,
> > > >         ret =3D queue_pages_range(mm, start, end, nmask,
> > > >                           flags | MPOL_MF_INVERT, &pagelist, true);
> > > >
> > > > +       if (ret =3D=3D 1)
> > > > +               ret =3D -EIO;
> > > >         if (ret < 0) {
> > > >                 err =3D ret;
> > > >                 goto up_out;
> > > >
> > > > (I don't really understand this code, so it can't be this simple, c=
an
> > > > it?  Why don't we just return -EIO from queue_folios_pte_range() if
> > > > this is the right answer?)
> > >
> > > Yeah, I'm trying to understand the expected behavior of this function
> > > to make sure we are not missing anything. I tried a simple fix that I
> > > suggested in my previous email and it works but I want to understand =
a
> > > bit more about this function's logic before posting the fix.
> >
> > So, current functionality is that after queue_pages_range() encounters
> > an unmovable page, terminates the loop and returns 1, mbind_range()
> > will still be called for the whole range
> > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1345),
> > all pages in the pagelist will be migrated
> > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1355)
> > and only after that the -EIO code will be returned
> > (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1362).
> > So, if we follow Matthew's suggestion we will be altering the current
> > behavior which I assume is not what we want to do.
>
> Right, I'm intentionally changing the behaviour.  My thinking is
> that mbind(MPOL_MF_MOVE | MPOL_MF_STRICT) is going to fail.  Should
> such a failure actually move the movable pages before reporting that
> it failed?  I don't know.
>
> > The simple fix I was thinking about that would not alter this behavior
> > is smth like this:
>
> I don't like it, but can we run it past syzbot to be sure it solves the
> issue and we're not chasing a ghost here?

Yes, I just finished running the reproducer on both upstream and
linux-next builds listed in
https://syzkaller.appspot.com/bug?extid=3Db591856e0f0139f83023 and the
problem does not happen anymore.
I'm fine with your suggestion too, just wanted to point out it would
introduce change in the behavior. Let me know how you want to proceed.
