Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD187F5F30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbjKWMmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbjKWMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:42:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08321A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:42:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ce5b72e743so135415ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700743358; x=1701348158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsML6oh+GFk07kkCjNMgU6G52KimBnWTxLnO5BIWqh8=;
        b=VEM2g8RRQVlLFa61beHZwrgIPBWYPwTL8NYwgwNdMw/n+7fHnxT4RCpwHdFLFa91Qq
         RBTRk5qjElTlI81AKT4aMw0SDmLtA/zZYFFryYFM/xMMcPhqnGUidBq36AKqeLEUPz28
         jk/SvmPZ9EmExefHQQenLamMH0teeSeqfGY6WSgXipOWVu9Octv9IBQ+5So/hg0L7bT4
         7yZOumP4Z6SbyEULSolU9fENGzNmY29fj6j6C0QvmEbn5/nCDLqZ5PybC+Jzad3BFF8B
         83h/QtHsmC+CMP+laeXrK2P+tHL6yWXWIP1sIY32/T0btZML5lJ+FwCM1WZWayUsx5cU
         ZeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700743358; x=1701348158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsML6oh+GFk07kkCjNMgU6G52KimBnWTxLnO5BIWqh8=;
        b=hQK7bu1MwI156rmKg0h0ib094BDrQ+C4irro9AKZCEa3JbqtoEM7dEzRv95wSiYWDL
         +jnnazRfuuJ5QEUYRO1O6mmorCg3NSyP8oXamyZUBsqQrWQihRv1SKNVKqKCcI4+c1dT
         ToWMrkdr0x90p5y5AamluMvgWj0eja/047EaO/yMhocv+nfyn7fCcKQnn2Aki6nzGfYH
         6Pl76TVewJVX3rtPFHqHdYrYyBdg0n04v+LmosdIBcCJcb2SkHdZIrSAatmRF/Eu9Ibm
         XRrT20Egt0C1YzXC1YzwSf/+mbherI8yVoJxQJgDMS+CGuE0I6zGe6h2uA0vtRyuuAA6
         J3zg==
X-Gm-Message-State: AOJu0YwgIJ2Xypvm1pUkvylzFmy08lN/SB/k3MyKXS0IuRKTu12SoSYN
        Pj93mT/V6aO2lnajP4PwmXVuTa0uwIBjjXQf9+TCGA==
X-Google-Smtp-Source: AGHT+IH6oXxgHLto7XAEMgVh0kI6+HnoNSfdi2ehuIln65JCtq2WYnEootglsdIqrw5cPMghkfJ9JajTNBp3Ks/Dt+E=
X-Received: by 2002:a17:902:f811:b0:1c2:446:5259 with SMTP id
 ix17-20020a170902f81100b001c204465259mr473845plb.19.1700743357726; Thu, 23
 Nov 2023 04:42:37 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLyCRyK4qpS2X8ssA6yxCDtEWR3dSsee2Lm6VCQUyD07VQ@mail.gmail.com>
 <2023112332-award-fanciness-2bcf@gregkh> <CANp29Y6ge-AhM+Byt3imGOpctRsgWiqBN-reuKvOJAzxBsTYLw@mail.gmail.com>
 <2023112306-diner-jawline-c7dc@gregkh>
In-Reply-To: <2023112306-diner-jawline-c7dc@gregkh>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 23 Nov 2023 13:42:26 +0100
Message-ID: <CANp29Y6MrCiiwXO4YJ0D8+YHRBY_4ii090mVq+rZ1EjXJH8Stg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] general protection fault in joydev_connect
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     xingwei lee <xrivendell7@gmail.com>,
        "syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com" 
        <syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:41=E2=80=AFAM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 23, 2023 at 10:32:26AM +0100, Aleksandr Nogikh wrote:
> > On Thu, Nov 23, 2023 at 9:55=E2=80=AFAM gregkh@linuxfoundation.org
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Nov 22, 2023 at 07:55:50PM +0800, xingwei lee wrote:
> > > > Hi. I have reproduced this bug with repro.txt and repro.c below:
> > > >
> > > > repro.txt
> > > > r0 =3D openat$uinput(0xffffffffffffff9c, &(0x7f0000000500), 0x802, =
0x0)
> > > > ioctl$UI_DEV_SETUP(r0, 0x405c5503, &(0x7f0000000080)=3D{{0x0, 0xfff=
f,
> > > > 0x3}, 'syz0\x00'})
> > > > ioctl$UI_DEV_CREATE(r0, 0x5501) (fail_nth: 51)
> > >
> > > You are using fault injection, which, by it's very name, causes fault=
s :)
> >
> > But those injected failures (that do not break the kernel, but just
> > emulate an error returned from a function that should be expected to
> > sometimes return an error) still should not lead to general protection
> > fault panics, shouldn't they?
>
> It all depends on what exactly the fault is happening for.  Some
> allocations in the kernel just "will not fail ever" so when you add
> fault injection testing, you are doing things that really can not ever
> happen.

Just in case - are you aware of any specific examples where fault
injection injects failures that should never ever happen? All
automatic kernel testing would benefit by making it not do this then.

From what I see in the code, fault injection already takes care of
avoiding such problems:
https://elixir.bootlin.com/linux/latest/source/mm/failslab.c#L25
https://elixir.bootlin.com/linux/latest/source/mm/fail_page_alloc.c#L30

>
> So the proof is first on the reporter, prove that this type of fault
> _can_ actually happen, and then, make a fix to properly handle it.
> Don't expect us to make a fix for something that can not actually occur,
> as that would be pointless (hint, we have been down this path before, it
> doesn't work...)
>
> thanks,
>
> greg k-h
