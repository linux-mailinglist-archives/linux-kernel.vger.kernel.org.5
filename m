Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34AE7A54EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjIRVUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIRVUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:20:41 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C188E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:20:35 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c0b5f984aso38168447b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695072035; x=1695676835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq0Us6jgc8KxbneLdF2D9i/7B/TB9s9lbtLNUZgPGF4=;
        b=C7k4c7EavGL4URc3nGseTLwXp3PU4FEc+sGzUR7JnIJca6vSRzofgsNp8VSn8BJeBE
         Nq0vT34+3t2EHuH/UIYUobQbIlph5hCduiviRtw/ZaOsPm9IMzKj5abOG1hGnqXW8xdE
         kppZlm9+2xPUNHTrd8VDCkp73jhmtxodVmiwaDU6CFW1BKNO483jeqvol3EKl5VIkzqK
         6RPpFdGSc5T1NvUDlMfIHtooK5isuxd2SegnYKg6iFukNrGnAAa4zBe2cvXoCMiWfDD5
         wJg7eXf+foAm81m24W2g0e3N3guMrcwQYsVkeUsh6WGU4T6jl4EwO+o8ijPyCcvpNbK/
         lE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695072035; x=1695676835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dq0Us6jgc8KxbneLdF2D9i/7B/TB9s9lbtLNUZgPGF4=;
        b=G73e/i2dVScJ9bC6W0jp7TW+GgNxoFHyDM5Vluu1XaBH0JmzxKQaVu+PY42Z0keFp3
         J3JCpgSlCQikqc7ApZ5IhOzHywMp0WWAvjX7LND+dTWV0oq6Md6kPxMnsv2UVHOgiMsw
         6JqiCkJzshwijLE0BiKsY0K7+68CKVMv74nnN8JleadNRaGY6LvQyBR0hzBipFeQwLXK
         Y9VxQbyPRd65vN4M4VlxMxNKbTnIEAqrejA4pgI76hpWUY30mBzQP8ScDHAGzDQomMff
         0vmte4IHAP+aph7P1S7hVpHp5sdppbaKG+F2G9TqzkRi6oEn6el5q5931ek23X+pPqvx
         GEzA==
X-Gm-Message-State: AOJu0YyXAZULba8bMmi4T8MPSkiahQF3Z/5s/8VOPn5SXrRKBjilg3PQ
        41lUovKsHp9Iz4agf1Cqbt2nMebtqkupLNwehNXRAw==
X-Google-Smtp-Source: AGHT+IGp/f9+93JwB0m2FgNAnlhhWWRiePhsGkj7brQqYKXV1+s/tl82YUmWcmyaM3pHlbm2zeMDDYLx5IjwXU5YkD0=
X-Received: by 2002:a0d:cb51:0:b0:59b:d899:f171 with SMTP id
 n78-20020a0dcb51000000b0059bd899f171mr9736557ywd.1.1695072034557; Mon, 18 Sep
 2023 14:20:34 -0700 (PDT)
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
 <CAJuCfpE8jnvL23W6fY4_HZf-969aEgvR3-LGRTUC-SFhPFju+w@mail.gmail.com> <c5c51578-efdc-7de-2238-4039fb1b6c36@google.com>
In-Reply-To: <c5c51578-efdc-7de-2238-4039fb1b6c36@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 18 Sep 2023 14:20:21 -0700
Message-ID: <CAJuCfpG4BrbXUypWsEwaSC8UZbciD-KytPGsoF802W6f4R9QTQ@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 7:44=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Fri, 15 Sep 2023, Suren Baghdasaryan wrote:
> > On Fri, Sep 15, 2023 at 9:09=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > Thanks for the feedback, Hugh!
> > > Yeah, this positive err handling is kinda weird. If this behavior (do
> > > as much as possible even if we fail eventually) is specific to mbind(=
)
> > > then we could keep walk_page_range() as is and lock the VMAs inside
> > > the loop that calls mbind_range() with a condition that ret is
> > > positive. That would be the simplest solution IMHO. But if we expect
> > > walk_page_range() to always apply requested page_walk_lock policy to
> > > all VMAs even if some mm_walk_ops returns a positive error somewhere
> > > in the middle of the walk then my fix would work for that. So, to me
> > > the important question is how we want walk_page_range() to behave in
> > > these conditions. I think we should answer that first and document
> > > that. Then the fix will be easy.
> >
> > I looked at all the cases where we perform page walk while locking
> > VMAs and mbind() seems to be the only one that would require
> > walk_page_range() to lock all VMAs even for a failed walk.
>
> Yes, I can well believe that.
>
> > So, I suggest this fix instead and I can also document that if
> > walk_page_range() fails it might not apply page_walk_lock policy to
> > the VMAs.
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 42b5567e3773..cbc584e9b6ca 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1342,6 +1342,9 @@ static long do_mbind(unsigned long start,
> > unsigned long len,
> >          vma_iter_init(&vmi, mm, start);
> >          prev =3D vma_prev(&vmi);
> >          for_each_vma_range(vmi, vma, end) {
> > +                /* If queue_pages_range failed then not all VMAs
> > might be locked */
> > +                if (ret)
> > +                        vma_start_write(vma);
> >                  err =3D mbind_range(&vmi, vma, &prev, start, end, new)=
;
> >                  if (err)
> >                          break;
> >
> > If this looks good I'll post the patch. Matthew, Hugh, anyone else?
>
> Yes, I do prefer this, to adding those pos ret mods into the generic
> pagewalk.  The "if (ret)" above being just a minor optimization, that
> I would probably not have bothered with (does it even save any atomics?)
> - but I guess it helps as documentation.
>
> I think it's quite likely that mbind() will be changed sooner or later
> not to need this; but it's much the best to fix this vma locking issue
> urgently as above, without depending on any mbind() behavioral discussion=
s.

I posted this patch at
https://lore.kernel.org/all/20230918211608.3580629-1-surenb@google.com/
to fix the immediate problem.
Thanks!

>
> Thanks,
> Hugh
