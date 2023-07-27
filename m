Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D043765B16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjG0SAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjG0SAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:00:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38030E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:00:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so10075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690480810; x=1691085610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTn2+kxGlhVp4f9iv6z1bXXGresETQByJPAsZA28KKw=;
        b=O9vN5oXrlqmXbSF6WeTcBJkLLHF4H1Q/1miHlegLRnV6C+vMSCP8ZAd+E+F3vEpmOO
         dOez8aEDj4dPCWiiwlXCgWmCD0KnBIgiylrn9LkmEZ6SaE7zWu1Ku+/s/HXGwR9C+H6S
         8hqrmWwHpqPyjvXrGGH8gCFKx7ty71CWff/iRa27sSTPhqHNXsBExUZ/Kt49yoAZLQfh
         mLvz2FZwyv568Wb+F1n/71KJh5U1+G0GDS9rXXcoXp0g7t1jOfah3H9lxhZCqjicYa0r
         JyLBntNWxqxNG4aZaNYof2jS7R8QLqMOgoLOvlpDib6sF0AHX6jYA1ftMbgLadRWlau3
         sjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690480810; x=1691085610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTn2+kxGlhVp4f9iv6z1bXXGresETQByJPAsZA28KKw=;
        b=N5D0vZ+5kinL717IBvgo6YfNvNmcOqJiDp13i/OmLP2bcWVKonRGEq8WTcCbQusSXa
         SJOpg1zjq35+BRj1itG4RyZzGrvfiLHKo8UqCbUWBaB1ALokkHdpYkAVhr678ZswZcQg
         VpBvxIqW5KfWBkmcnyVjScXuVHH1A3m38O6BPIx7KxHUpcA3LsBb41jxZefW2lkUNqaA
         ONQFllZ7t2ZI5VGgBPnneW0YYU9CtVZT0529K/BwE8WJYMgrLPdKsQMRC7nn/CjWfacA
         0G+I3ENZ1E34OWvEpUDKIBsT9ged03X9Vk1tmJ/J62pUdjlIeh/Mns38WYj7yGj5EZ6p
         tR2A==
X-Gm-Message-State: ABy/qLbb3hI1GP5YHFHazhcgSesIaq8385oyefMW29LqysqOSlNKanV2
        kdHjQWKGjOZAkXR029iAknGP8fW8Gd7IHVZPCeKrQg==
X-Google-Smtp-Source: APBJJlGuQWxAL4fqerBwoIv5mRHCYPIZPVe1BZ+MTPguHtmK71dR2/dAWktplHcOEGAI+WfFEOlqcL34Mu47y4FY3ac=
X-Received: by 2002:a05:600c:3d1a:b0:3f1:73b8:b5fe with SMTP id
 bh26-20020a05600c3d1a00b003f173b8b5femr9532wmb.3.1690480810201; Thu, 27 Jul
 2023 11:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000607ff905ffc8e477@google.com> <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver> <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
In-Reply-To: <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Jul 2023 19:59:33 +0200
Message-ID: <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
To:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
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

On Thu, Jul 27, 2023 at 7:22=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Thu, Jul 27, 2023 at 9:48=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com> [23072=
6 02:57]:
> > > syzbot has bisected this issue to:
> > >
> > > commit a52f58b34afe095ebc5823684eb264404dad6f7b
> > > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Date:   Mon Jul 24 18:54:10 2023 +0000
> > >
> > >     mm: handle faults that merely update the accessed bit under the V=
MA lock
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D178358=
5ea80000
> > > start commit:   [unknown]
> > > git tree:       linux-next
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D144358=
5ea80000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1043585ea=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df481ab36c=
e878b84
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8645fe63c4d=
22c8d27b8
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1697cec=
9a80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1566986ea=
80000
> > >
> > > Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com
> > > Fixes: a52f58b34afe ("mm: handle faults that merely update the access=
ed bit under the VMA lock")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bi=
section
> >
> > This is caused by walking the maple tree without holding the mmap or rc=
u
> > read lock when per-vma locking is used for the page fault.
> >
> > We could wrap the find_mergeable_anon_vma() walk with an rcu read lock,
> > but I am unsure if that's the correct way to handle this as the anon_vm=
a
> > lock is taken later in __anon_vma_prepare().  Note that the anon_vma
> > lock is per-anon_vma, so we cannot just relocate that lock.
>
> Hmm. lock_vma_under_rcu() specifically checks for vma->anon_vma=3D=3DNULL
> condition (see [1]) to avoid going into find_mergeable_anon_vma() (a
> check inside anon_vma_prepare() should prevent that). So, it should
> fall back to mmap_lock'ing.

This syzkaller report applies to a tree with Willy's in-progress patch
series, where lock_vma_under_rcu() only checks for vma->anon_vma if
vma_is_anonymous() is true - it permits private non-anonymous VMAs
(which require an anon_vma for handling write faults)  even if they
don't have an anon_vma.

The commit bisected by syzkaller
(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3Da52f58b34afe095ebc5823684eb264404dad6f7b)
removes the vma_is_anonymous() check in handle_pte_fault(), so it lets
us reach do_wp_page() with a non-anonymous private VMA without
anon_vma, even though that requires allocation of an anon_vma.

So I think this is pretty clearly an issue with Willy's in-progress
patch series that syzkaller blamed correctly.



> Jann Horn is fixing an issue with this check in [2] which happens
> before we take the vma lock. So, it's possible that this race is
> causing a call to find_mergeable_anon_vma() while holding per-VMA
> lock. Another possibility is that the recent addition of vma_is_tcp()
> is messing things up here... Either way, find_mergeable_anon_vma()
> should never be called under per-VMA locks because it relies on
> neighboring VMAs to be stable and we do not lock those.
>
> [1] https://elixir.bootlin.com/linux/v6.5-rc3/source/mm/memory.c#L5396
> [2] https://lore.kernel.org/all/20230726214103.3261108-3-jannh@google.com=
/
>
>
> >
> > I'm wondering if we need find_mergeable_anon_vma() to take a read lock
> > on the VMA which contains the anon_vma to ensure it doesn't go away?
> > Maybe a find_and_lock_mergeable_anon_vma() and return a locked anon_vma=
?
> > Basically lock_vma_under_rcu(), anon_vma_lock_write(), vma_end_read().
> >
> > Thoughts?
> >
> > Thanks,
> > Liam
> >
