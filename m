Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883DD7FC2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbjK1PFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbjK1PFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:05:36 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D8D62
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:05:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfaf05db73so159665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701183942; x=1701788742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIyfxB2pi1DD/xFaz4h7up8NvJi6wi3KWQr5MkbyogY=;
        b=XYACjMUBcKtzd73PNVSbY7odkcNloAHL4x4+yCQl9nrMJNGi8WAUlwKkcn63Hm74q/
         owd8eAlyDuMh1xoLNh7NlHGqRPE0OgNAhFEt205JlyGkkZa8dYYbLGOkkyQE8BRahvy/
         BfsZeQoxusV/48HKvuefFSYxfFUCXKL3M1LYDqynLDXFWjRoSxhrFA3AiFAUrekk5/FJ
         ZJgMC2uanJIaWyVDyP3qpYHK4sFH9NQxzECkKxNcMiZmNwk81CHfBscWqMuWkUlRJJ4d
         /FEIzhxvZBJhcHsTZ2KTRAkHqx0ibCIGOy96UJSTHqF/nrgollAnp6zcG3sTwzdFqK2H
         wf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183942; x=1701788742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIyfxB2pi1DD/xFaz4h7up8NvJi6wi3KWQr5MkbyogY=;
        b=SC8h4a3o13qbPp/3dBJa0tL1AhuUEjZ5pcXkugOhTlEsN+A7ym8CHSYgredIxmgBMG
         3JYugcoX6Z+W+NelxooGD9fFk5U6wdHp2+pdWz+3Kn2Ev4yLYQ1UmFuQvhTcyz0IolJ4
         x5XJEc8+txqP8nZz80MjaoYnf4D02gDX9Kko29D/z0uw4OCE7gXByUdR4Fmv/Ekd2lCy
         jYd1fb1MjE9yPYcl/Qma6eU0eKjv5P2IpZh91iW6FF9TktEk5XVhP3Ti21l5aOmPaWDo
         uQsmuMy4UF/cwJKA9ehYhLeJLbWV9RnyZ/6HbIx1PvVCcjiF/ru1TF+cvW2tsil8FlW5
         Qscg==
X-Gm-Message-State: AOJu0YwoP7ChH09MMD3rAxjWDoP4UrtujThCrmyRjJoMzgRcSSBLboyk
        D5NUBzTbPBA87YAwMFAl5AOE69US1YheKOConi4gpg==
X-Google-Smtp-Source: AGHT+IGrQdlGKDgA9FHhDONGBYH9TrWtTN+htijQaz06c0I9y8Wie/gSN4rLC6ODCVB86yKfb2AlxQrSgbGy8HeQXRo=
X-Received: by 2002:a17:902:c113:b0:1cf:b1d3:72ab with SMTP id
 19-20020a170902c11300b001cfb1d372abmr709344pli.27.1701183942051; Tue, 28 Nov
 2023 07:05:42 -0800 (PST)
MIME-Version: 1.0
References: <00000000000029fce7060ad196ad@google.com> <CAM0EoM=20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA@mail.gmail.com>
In-Reply-To: <CAM0EoM=20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 28 Nov 2023 16:05:25 +0100
Message-ID: <CANp29Y6UOHhvwf=hh7PFRsyZspJx=w==4=A8TjPEQqXeYvBD+A@mail.gmail.com>
Subject: Re: [syzbot] Monthly net report (Nov 2023)
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamal,

This sounds interesting, thanks for the suggestion!

It would be a lot of emails though, so maybe we could randomly pick a
few of them each time.
I've filed https://github.com/google/syzkaller/issues/4369

--=20
Aleksandr

On Thu, Nov 23, 2023 at 3:03=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Nov 23, 2023 at 8:12=E2=80=AFAM syzbot
> <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com> wrote:
> >
> > Hello net maintainers/developers,
> >
> > This is a 31-day syzbot report for the net subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/net
> >
>
> Hi,
> Could you please Cc the stakeholders for each issue (especially when
> there is a reproducer)? Not everybody reads every single message that
> shows up in the kernel.
>
> cheers,
> jamal
>
> > During the period, 5 new issues were detected and 13 were fixed.
> > In total, 77 issues are still open and 1358 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Ref  Crashes Repro Title
> > <1>  3878    Yes   KMSAN: uninit-value in eth_type_trans (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D0901d0cc75=
c3d716a3a3
> > <2>  892     Yes   possible deadlock in __dev_queue_xmit (3)
> >                    https://syzkaller.appspot.com/bug?extid=3D3b165dac15=
094065651e
> > <3>  860     Yes   INFO: task hung in switchdev_deferred_process_work (=
2)
> >                    https://syzkaller.appspot.com/bug?extid=3D8ecc009e20=
6a956ab317
> > <4>  590     Yes   INFO: task hung in rtnetlink_rcv_msg
> >                    https://syzkaller.appspot.com/bug?extid=3D8218a8a0ff=
60c19b8eae
> > <5>  390     Yes   WARNING in kcm_write_msgs
> >                    https://syzkaller.appspot.com/bug?extid=3D52624bdfbf=
2746d37d70
> > <6>  373     Yes   INFO: rcu detected stall in corrupted (4)
> >                    https://syzkaller.appspot.com/bug?extid=3Daa7d098bd6=
fa788fae8e
> > <7>  249     Yes   INFO: rcu detected stall in tc_modify_qdisc
> >                    https://syzkaller.appspot.com/bug?extid=3D9f78d5c664=
a8c33f4cce
> > <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D1d26c4ed77=
bc6c5ed5e6
> > <9>  172     No    INFO: task hung in linkwatch_event (3)
> >                    https://syzkaller.appspot.com/bug?extid=3Dd4b2f8282f=
84f54e87a1
> > <10> 154     Yes   WARNING in print_bfs_bug (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D630f83b42d=
801d922b8b
> >
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
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAM0EoM%3D20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA%40ma=
il.gmail.com.
