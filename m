Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD444754131
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjGNRr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjGNRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1335AD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:46:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so7965e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689356814; x=1691948814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V79V8Ob9kDVtoKhHxfd/ZHppf+Xb+pXM39lQ/ZKj5AA=;
        b=S31bnNT3GDqZ5z203JkpEIu36kZcKiyLgCYoB7XGIpR6wqV4kTdPHcQKQYkUUIPwfs
         yduMqjrvndVREn4OFHzB+nMXt+fogQeE0uAZffvq0vW1cLnwUr/ng5EaaS5oYbARdzIq
         XYzcIAUquwxrHPeAI1L5ctcYveELaQLcbhI+KMRnjk0fJus/p+zVTc0SL3gRVAYbDEQ+
         0BQFVJOSNfe5bJW4p4u8J4QB6oCYcsTx43w2Ml1hnB2TOV/cCrQZWeHuXg3n0JlSKE18
         7sZMld6BvPNRiHHWifIdVCMoWG0PUQGaz4VYUttZQDpuqjiHKchpP1o6f3vssJ08x1/8
         pGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356814; x=1691948814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V79V8Ob9kDVtoKhHxfd/ZHppf+Xb+pXM39lQ/ZKj5AA=;
        b=CpYErdoV6sOlXxdEdLohp7sF3pr4sAwvMA3/zrYOnDjd2hhJS6dcWoQypanY7nO9bX
         08cl5yoMn4qtj4Gw4i1/bRLEaUdY2j/V+MRxQXUPmZRLMd8AhAIAj5M8CsNQioj+tOvw
         VziuFaTZZGAf+/H62VJSjG1Fv/FhtGjJnzLnO0K+42Vz94Ukj3E1KturD5nhaz3vS86N
         2E1WNH+FYpaOu4E2tm0kAHuVjFz5wTDh4P2mIWUmfjbXZM/z8WjRUIRHJnSskc/SeieQ
         dQRX8/E1A7dkFordDcjbavWmC4DDYbtYES6q6Si4i8twuKOdVhaM3FKP9q2/GS/HLWpd
         8dYw==
X-Gm-Message-State: ABy/qLbGxdclEV87k9vUVzeMY/TWH25Ax/2RW4MKQZFnU3rA/12BGMMV
        EYoQqBLibk6K/Pf0YphtQAPixuubRuFx0CTjGbG02Q==
X-Google-Smtp-Source: APBJJlEgmPkFMojaotDjbFoM8e1VgkXNNe+Uom0kHyquw6TPemNfxqNuS0Ui3xa5/ip2rpjClcP+hofflb35Wa/RkgQ=
X-Received: by 2002:a05:600c:8609:b0:3f1:73b8:b5fe with SMTP id
 ha9-20020a05600c860900b003f173b8b5femr345595wmb.3.1689356813789; Fri, 14 Jul
 2023 10:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000075fd0505ff917517@google.com> <CAKYAXd9Wv5Swj4fouCLYbdyjWYhT39C3TiHgm-fRiKS_2=zsTA@mail.gmail.com>
In-Reply-To: <CAKYAXd9Wv5Swj4fouCLYbdyjWYhT39C3TiHgm-fRiKS_2=zsTA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 14 Jul 2023 19:46:42 +0200
Message-ID: <CANp29Y7ynmqhmRQ0hABs=uVHQY1sN+Ldw3V93UGSxh+SqfYC=Q@mail.gmail.com>
Subject: Re: [syzbot] Monthly fat report (Jul 2023)
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     syzbot <syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 3:45=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> 2023-07-03 18:04 GMT+09:00, syzbot
> <syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>:
> > Hello fat maintainers/developers,
> Hi Syzbot,
>
> It's not fat, it's exfat :)

I'll look into renaming it on syzbot :)

> >
> > This is a 31-day syzbot report for the fat subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/fat
> >
> > During the period, 3 new issues were detected and 0 were fixed.
> > In total, 11 issues are still open and 20 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 347     Yes   possible deadlock in filemap_fault
> >
> > https://syzkaller.appspot.com/bug?extid=3D7736960b837908f3a81d
> > <2> 257     Yes   possible deadlock in exfat_get_block
> >
> > https://syzkaller.appspot.com/bug?extid=3D247e66a2c3ea756332c7
> > <3> 181     Yes   possible deadlock in exfat_iterate
> >
> > https://syzkaller.appspot.com/bug?extid=3D38655f1298fefc58a904
> > <4> 100     Yes   possible deadlock in exc_page_fault
> >
> > https://syzkaller.appspot.com/bug?extid=3D6d274a5dc4fa0974d4ad
> > <5> 39      Yes   possible deadlock in do_user_addr_fault
> >
> > https://syzkaller.appspot.com/bug?extid=3D278098b0faaf0595072b
> > <6> 2       Yes   KASAN: slab-use-after-free Write in
> > collect_expired_timers

#syz set <6> subsystems: reiserfs

> >
> > https://syzkaller.appspot.com/bug?extid=3Dfb8d39ebb665f80c2ec1
> > <7> 1       Yes   BUG: corrupted list in __mark_inode_dirty

#syz set <7> subsystems: reiserfs

> >
> > https://syzkaller.appspot.com/bug?extid=3D4a16683f5520de8e47c4
> >
>
> Can you check if deadlock problem(<1>, <2>, <3>, <4>, <5>, <6>) are
> fixed with the following patch ?
> https://lore.kernel.org/lkml/20230714084354.1959951-1-sj1557.seo@samsung.=
com/T/#u

We currently unfortunately don't support bulk testing, I've sent a few
requests manually (<1>, <3>, <4>):
https://groups.google.com/g/syzkaller-bugs/c/ynCUkcnqEiQ/m/qsVWSdWOBAAJ
https://groups.google.com/g/syzkaller-bugs/c/jKpqY82OuZk
https://groups.google.com/g/syzkaller-bugs/c/7CO-77jYTAQ/m/lBmXby-OBAAJ

>
> Numbers <6>, <7> are not exfat issues. Can you remove them in your list?

Thanks for triaging! I've updated their subsystems to reiserfs (see
commands above).

>
> Thanks.
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > To disable reminders for individual bugs, reply with the following comm=
and:
> > #syz set <Ref> no-reminders
> >
> > To change bug's subsystems, reply with:
> > #syz set <Ref> subsystems: new-subsystem
> >
> > You may send multiple commands in a single email message.
> >
>
> --
