Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBA75FEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGXSFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGXSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:05:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78BE4E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:05:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fd28ae8b90so8765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690221927; x=1690826727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXVtiZeWAsgcO5Uj7Vc+lACqDmNUtaa8iYJF2/CJT1o=;
        b=fZfJyvw9HcAYHgKr3pCXvL1l79KpzXXPCdKxcLq6l2asVwqdYOCiVzNOXGRUxmWxFK
         Y9t2/CObyT3rpuvAioAEUi94Hav+K6kQL9qfiKE9e4sE5+bYyoOa4uLgUR8bbAxG4C6e
         IhOGmb5H1/Zpz1kKpVedCfTekSce+YADkVHkqwryZH9DTHRKuIAdEzkn9P+ihTsg/9x7
         u/AP2C7eun3VTyL94gTlTAu6bp3nNs4sCvu9zMY7DbO5RB4vH2ZZzwAE3ll1/5Ujiux2
         otrIR0MpHRvGgRxZmNr+7TfjA//hgfvNk30gZ4g3ZCcJILpxpzDsP6yf2ic1MhcyPqzs
         w/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221927; x=1690826727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXVtiZeWAsgcO5Uj7Vc+lACqDmNUtaa8iYJF2/CJT1o=;
        b=BZvz6PlWqLe7VJqTtwlPcv7JBNvYS7rdypvEQZoCwi8QCGUEb8HyZyDOtfHzw761CO
         im5jZoQB22Ko8j9D14I+v8zoRgu8GWOOevBCYiW627UVGGWOlcXyt8TweQgzhGYPFvO5
         w5rriTX9GUtIVulGwPt/aEIFGw70MTiIEVW4pjqLE0Wi2AD0jAfN0QY07w6UZgNZZpYf
         sXtoQpniIJqaNIQCBL55rN3+mcjK2mWeR3txkhlvfuZJs39oBKi8lAkxr6I2U/GErbte
         bNLwxkvq41OBRVFDA1TkZFFP/t73jqx44tlZ392+1AiKLKyEo3a3EqWiUgYgR8xaNczf
         uUnQ==
X-Gm-Message-State: ABy/qLZ9mqf8HZDPT2sYm3w7GultmNQr7JkFKzNFJzpoY3L3u9nI4pGo
        NQ9pkBpdH8k5v+ZIe9lDMd8H/p6AJlmdqm+Na59sew==
X-Google-Smtp-Source: APBJJlFCPdsl6nh5jA+Fk1fQeWt0WxZdkV49D3ro8D2jqRNuMQ7tmvYchf2GWPY8Uszw9dPB7hfe3rDoIqJww7FyrJg=
X-Received: by 2002:a05:600c:3d0b:b0:3f7:3e85:36a with SMTP id
 bh11-20020a05600c3d0b00b003f73e85036amr182341wmb.7.1690221926630; Mon, 24 Jul
 2023 11:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230724033714.175340-1-yiyang13@huawei.com> <cd1019d0-55b8-6276-dd5e-3a7a9264fe06@kernel.org>
In-Reply-To: <cd1019d0-55b8-6276-dd5e-3a7a9264fe06@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Jul 2023 20:04:50 +0200
Message-ID: <CAG48ez1xRr4dtF9skZ=ruXpbi82PutTWGqTgeyk9RAQDFZCDKQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: tty_jobctrl: fix pid memleak in disassociate_ctty()
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Yi Yang <yiyang13@huawei.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, guozihua@huawei.com
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

On Mon, Jul 24, 2023 at 10:28=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
> On 24. 07. 23, 5:37, Yi Yang wrote:
> > There is a pid leakage:
> > ------------------------------
> > unreferenced object 0xffff88810c181940 (size 224):
> >    comm "sshd", pid 8191, jiffies 4294946950 (age 524.570s)
> >    hex dump (first 32 bytes):
> >      01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
> >      ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
> >    backtrace:
> >      [<ffffffff814774e6>] kmem_cache_alloc+0x5c6/0x9b0
> >      [<ffffffff81177342>] alloc_pid+0x72/0x570
> >      [<ffffffff81140ac4>] copy_process+0x1374/0x2470
> >      [<ffffffff81141d77>] kernel_clone+0xb7/0x900
> >      [<ffffffff81142645>] __se_sys_clone+0x85/0xb0
> >      [<ffffffff8114269b>] __x64_sys_clone+0x2b/0x30
> >      [<ffffffff83965a72>] do_syscall_64+0x32/0x80
> >      [<ffffffff83a00085>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > It turns out that there is a race condition between disassociate_ctty()=
 and
> > tty_signal_session_leader(), which caused this leakage.
> >
> > The pid memleak is triggered by the following race:
> > task[sshd]                     task[bash]
> > -----------------------        -----------------------
> >                                 disassociate_ctty();
> >                                 spin_lock_irq(&current->sighand->sigloc=
k);
> >                                 put_pid(current->signal->tty_old_pgrp);
> >                                 current->signal->tty_old_pgrp =3D NULL;
> >                                 tty =3D tty_kref_get(current->signal->t=
ty);
> >                                 spin_unlock_irq(&current->sighand->sigl=
ock);
> > tty_vhangup();
> > tty_lock(tty);
> > ...
> > tty_signal_session_leader();
> > spin_lock_irq(&p->sighand->siglock);
> > ...
> > if (tty->pgrp) //tty->pgrp is not NULL
> > p->signal->tty_old_pgrp =3D get_pid(tty->pgrp); //An extra get
> > spin_unlock_irq(&p->sighand->siglock);
> > ...
> > tty_unlock(tty);
> >                                 if (tty) {
> >                                     tty_lock(tty);
> >                                     ...
> >                                     put_pid(tty->pgrp);
> >                                     tty->pgrp =3D NULL; // It's too lat=
e
> >                                     ...
> >                                     tty_unlock(tty);
> >                                 }
> >
> > The issue is believed to be introduced by commit c8bcd9c5be24 ("tty:
> > Fix ->session locking") who moves the unlock of siglock in
> > disassociate_ctty() above "if (tty)", making a small window allowing
> > tty_signal_session_leader() to kick in. It can be easily reproduced by
> > adding a delay before "if (tty)" and at the entrance of
> > tty_signal_session_leader() "tty_signal_session_leader()".
>
> Funny, the commit effectively reverted c70dbb1e79a1 ("tty: fix memleak
> in alloc_pid") which appears to be fixing exactly what you are reporting
> now again.
>
> > To fix this issue, we move put_pid() after "if (tty)".
> >
> > Fixes: c8bcd9c5be24 ("tty: Fix ->session locking")
> > Signed-off-by: Yi Yang <yiyang13@huawei.com>
> > Co-developed-by: GUO Zihua <guozihua@huawei.com>
> > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > ---
> > v2:Completely refactor the solution, avoid the use of PF_EXITING flag a=
nd
> > do put_pid() in disassociate_ctty() again instead.
> > ---
> >   drivers/tty/tty_jobctrl.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
> > index 0d04287da098..17a6565f428b 100644
> > --- a/drivers/tty/tty_jobctrl.c
> > +++ b/drivers/tty/tty_jobctrl.c
> > @@ -300,12 +300,7 @@ void disassociate_ctty(int on_exit)
> >               return;
> >       }
> >
> > -     spin_lock_irq(&current->sighand->siglock);
> > -     put_pid(current->signal->tty_old_pgrp);
> > -     current->signal->tty_old_pgrp =3D NULL;
> > -     tty =3D tty_kref_get(current->signal->tty);
> > -     spin_unlock_irq(&current->sighand->siglock);
> > -
> > +     tty =3D get_current_tty();
> >       if (tty) {
> >               unsigned long flags;
> >
> > @@ -320,6 +315,11 @@ void disassociate_ctty(int on_exit)
> >               tty_kref_put(tty);
> >       }
> >
> > +     spin_lock_irq(&current->sighand->siglock);
> > +     put_pid(current->signal->tty_old_pgrp);
> > +     current->signal->tty_old_pgrp =3D NULL;
> > +     spin_unlock_irq(&current->sighand->siglock);
>
> It _appears_ to be correct (the locking of all this is quite hairy). But
> at the very least, this block deserves a comment why we do it the second
> time.

What is "it" in "do it the second time"? Are you referring to calling
get_current_tty()?
