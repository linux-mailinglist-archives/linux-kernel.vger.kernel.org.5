Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55EC765A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjG0RXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjG0RW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:22:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62932D71
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:22:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d0e009433c4so1163833276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690478576; x=1691083376;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2qqdXVsC101+4wt0YNTBcpkNKMosTx2VcTllojLGFo=;
        b=3Luf5hWJJHyKrDrRoFrDEk5vGnjxdUK1FUF3iNZwRQCZZ5kHDG2RYy9OI66ACLBDel
         QbapltJo/zoFMXdiTSs8W6mVyY4M2XNtpEAxJj2bq6sVNuhnXZo4SeUyAPycZr/8mY+e
         ZiJ2stQbHkHTRflIFzPqWl+V2lkYJpY/beQfOLK8g6hNsvbti4Yi9a3lLStQ9P93iQQc
         9joxa/0UGgypjOUwHgAl2qtrQnkPS14VXBsYMYQjP5CkDzFnwHP2u05LDjPwZ10+M2Nq
         l9mWxA8iehb+Jt3f0J4nKCQRNuakSITr6N61AZ1KH3vyRbv0ncyAueA7lhUR+8SRpkti
         J+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478576; x=1691083376;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2qqdXVsC101+4wt0YNTBcpkNKMosTx2VcTllojLGFo=;
        b=R+HQzJh4+JqzdOxkthwYz/FraUm1A7XuTAl0FNPaHXcApALwGmltiiJadmvY34Ql/a
         9y2bDL3jYfFzaNdUTXxrjtf9BkJUtTQEJ6HB3vOyKl2I2G9D+KLmXak671hS9ox9AkO0
         3o3S6VFeSQbWGTRtxL3Le6LJaBrAxeFYDEOiK3EYa4koDgUKWEd0y2NNgG+m9Zxo9qeQ
         qbgoRpTffdcWEwJaDI9uB8y1MOsxg8HMFt4df5sBM93Pg5wTX1WWIfkeSYjo/3I6/50i
         ljDeXAyHiFDxG2vSEb6fACSTlrsrLJzCY1/AYcoJ7ZcMfzLaZcsGXMNUt9VWrc/WcMLG
         q5Qg==
X-Gm-Message-State: ABy/qLaTmkUyBntX76JO2Mz7dhPj0XZK5VgItdQ8xdOKHbF+HPYM5U5J
        bm6PJRpdFS75Qe82XFKe47N4XSSFEBokqtvE/VtqTQ==
X-Google-Smtp-Source: APBJJlFQvLbUPM5Q4le2ck0tRcp44lp4V6vBmLyRca2WBGgZsUBJo/0bIpra6gCawf09PVaakVfBNgEzVJaTuHPfspk=
X-Received: by 2002:a25:c78e:0:b0:d23:d12:edf5 with SMTP id
 w136-20020a25c78e000000b00d230d12edf5mr18755ybe.44.1690478575733; Thu, 27 Jul
 2023 10:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000607ff905ffc8e477@google.com> <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver>
In-Reply-To: <20230727164757.e2di75xjybxncohn@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 27 Jul 2023 10:22:42 -0700
Message-ID: <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 9:48=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com> [230726 =
02:57]:
> > syzbot has bisected this issue to:
> >
> > commit a52f58b34afe095ebc5823684eb264404dad6f7b
> > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Date:   Mon Jul 24 18:54:10 2023 +0000
> >
> >     mm: handle faults that merely update the accessed bit under the VMA=
 lock
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1783585e=
a80000
> > start commit:   [unknown]
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1443585e=
a80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1043585ea80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df481ab36ce8=
78b84
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8645fe63c4d22=
c8d27b8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1697cec9a=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1566986ea80=
000
> >
> > Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com
> > Fixes: a52f58b34afe ("mm: handle faults that merely update the accessed=
 bit under the VMA lock")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> This is caused by walking the maple tree without holding the mmap or rcu
> read lock when per-vma locking is used for the page fault.
>
> We could wrap the find_mergeable_anon_vma() walk with an rcu read lock,
> but I am unsure if that's the correct way to handle this as the anon_vma
> lock is taken later in __anon_vma_prepare().  Note that the anon_vma
> lock is per-anon_vma, so we cannot just relocate that lock.

Hmm. lock_vma_under_rcu() specifically checks for vma->anon_vma=3D=3DNULL
condition (see [1]) to avoid going into find_mergeable_anon_vma() (a
check inside anon_vma_prepare() should prevent that). So, it should
fall back to mmap_lock'ing.
Jann Horn is fixing an issue with this check in [2] which happens
before we take the vma lock. So, it's possible that this race is
causing a call to find_mergeable_anon_vma() while holding per-VMA
lock. Another possibility is that the recent addition of vma_is_tcp()
is messing things up here... Either way, find_mergeable_anon_vma()
should never be called under per-VMA locks because it relies on
neighboring VMAs to be stable and we do not lock those.

[1] https://elixir.bootlin.com/linux/v6.5-rc3/source/mm/memory.c#L5396
[2] https://lore.kernel.org/all/20230726214103.3261108-3-jannh@google.com/


>
> I'm wondering if we need find_mergeable_anon_vma() to take a read lock
> on the VMA which contains the anon_vma to ensure it doesn't go away?
> Maybe a find_and_lock_mergeable_anon_vma() and return a locked anon_vma?
> Basically lock_vma_under_rcu(), anon_vma_lock_write(), vma_end_read().
>
> Thoughts?
>
> Thanks,
> Liam
>
