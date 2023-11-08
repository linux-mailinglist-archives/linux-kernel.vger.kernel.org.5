Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289357E4F12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbjKHCqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjKHCqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:46:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA110E4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:46:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so669121a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699411580; x=1700016380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dj3oJkGhFmW0PQVdBh3/PRKGgG3RUdlu0nDUsZ6Xc0=;
        b=AQCQLwYzKSMdj4TJWL48FeSsSmT6arDLGZcZIeTw1Jxo2FgjbvbzMX48hyk7nHQcVR
         EOa5/vKSL9fPFlsYmumWyAIK7ljbwmJGlqkwlHbIuEPoylaJX/TDYAAXWMkdUs3SB/5F
         iFpQsgzgImIWdGgEpHvk8CUw8NTZEGZrjIWu1KmrGm27AX7vSIyilhybU4ItXU/lIU1P
         DDZQf0NUESDLgU3MFt7ZwHFALGQkuDaiD661PRqnpZEGLECEZ2JhbmSedSBoLpiSxesM
         YPVFq6+zM6jm+TgFbAMOgYNhcBoE9q1a07JCSgazsjWyrgz75mb66GCrCoeKZWAU0gbt
         ccJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411580; x=1700016380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dj3oJkGhFmW0PQVdBh3/PRKGgG3RUdlu0nDUsZ6Xc0=;
        b=gE9fFDqN5EjlezNYMm8ScbLwjQ1Lh4y45rryhLywLpDWisd+KrgnkqASFP0LocW7yp
         JjU6bBPrqInMAcVK1+/lHHGp/veE/2Z0hB2PIlM0MAOfu/9As/Nl/oDYxfSsbvEsPs6i
         Hx6QgEi7rdp1tTn2HfDTWQVd52ZzCSfnc3O1MrL44sCenLwf9Ay2fBZIaKyuJZ7T1485
         AK2cwVFn/a3SM0xfv/5+Nhx+VAF+HgIm0/3gTw18qU/fYHiuPUYCn+hxBw+KQxRUBASM
         LnoyInqSznCWiNtrRC4zlwXrA6RDsOXQHdx50phbCSa11CmxWY2s7X2d6aZjc9yKULbg
         bwMA==
X-Gm-Message-State: AOJu0Yx4WTYULaE2t177SUEJwOQS912WY3SlY3pBsNqVEv/HKvKu2OzP
        R4bHu7qnQeWodLO3WyGCrAXUKn/sBoIwn1932gep0un0
X-Google-Smtp-Source: AGHT+IFj33PnvnqPH/KBUjDg49VNjbJ1PxEOtdO55wqT6gPUPSzHv1aeD1geze2d5vHQ/mH+Q8u6HYob9M+ZmYScYo4=
X-Received: by 2002:aa7:c2ca:0:b0:542:f0af:21e6 with SMTP id
 m10-20020aa7c2ca000000b00542f0af21e6mr571437edp.14.1699411580206; Tue, 07 Nov
 2023 18:46:20 -0800 (PST)
MIME-Version: 1.0
References: <1698888042-17199-1-git-send-email-zhiguo.niu@unisoc.com> <fbba559c-59e2-94f1-52d6-94960a13f682@kernel.org>
In-Reply-To: <fbba559c-59e2-94f1-52d6-94960a13f682@kernel.org>
From:   Zhiguo Niu <niuzhiguo84@gmail.com>
Date:   Wed, 8 Nov 2023 10:46:08 +0800
Message-ID: <CAHJ8P3JAHOSav7YmZeTDUzbEYgzo_ja5eEadtXAnE4Ufj9isqg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix thread name cannot be fully displayed
To:     Chao Yu <chao@kernel.org>
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chao,

On Tue, Nov 7, 2023 at 10:53=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/11/2 9:20, Zhiguo Niu wrote:
> > Because the length of task'name in task_struct can not exceed
> > 16 characters, f2fs some thread'name cannot be fully displayed,
> > including important device number information.
> > If there are more than one partition using the f2fs file system,
> > it is very inconvenient to match partitions and their threads.
> >
> > The following examples show that 4 partitions all use f2fs file system
> > PID: 400    TASK: ffffff80f120c9c0  CPU: 2   COMMAND: "f2fs_discard-25"
> > PID: 392    TASK: ffffff80f6b75880  CPU: 3   COMMAND: "f2fs_discard-25"
> > PID: 400    TASK: ffffff80f120c9c0  CPU: 2   COMMAND: "f2fs_discard-25"
> > PID: 392    TASK: ffffff80f6b75880  CPU: 3   COMMAND: "f2fs_discard-25"
> > PID: 510    TASK: ffffff80dd62c9c0  CPU: 0   COMMAND: "f2fs_ckpt-254:4"
> > PID: 255    TASK: ffffff80f2268000  CPU: 3   COMMAND: "f2fs_ckpt-259:4"
> > PID: 398    TASK: ffffff80f120ac40  CPU: 2   COMMAND: "f2fs_ckpt-259:4"
> > PID: 390    TASK: ffffff80f6b76740  CPU: 3   COMMAND: "f2fs_ckpt-259:4"
> > PID: 511    TASK: ffffff80dd629d80  CPU: 3   COMMAND: "f2fs_flush-254:"
> > PID: 399    TASK: ffffff80f120bb00  CPU: 2   COMMAND: "f2fs_flush-259:"
> > PID: 391    TASK: ffffff80f6b70000  CPU: 3   COMMAND: "f2fs_flush-259:"
> > PID: 256    TASK: ffffff80f226d880  CPU: 6   COMMAND: "f2fs_flush-259:"
> >
> > We can use the name format such as f2fs_gc-xxx, as saw in device:
> > PID: 260    TASK: ffffff80f8c2e740  CPU: 3   COMMAND: "f2fs_gc-259:44"
> > PID: 420    TASK: ffffff80f6505880  CPU: 2   COMMAND: "f2fs_gc-259:41"
> > PID: 393    TASK: ffffff80f6b72c40  CPU: 1   COMMAND: "f2fs_gc-259:40
> > PID: 513    TASK: ffffff80dd62e740  CPU: 1   COMMAND: "f2fs_gc-254:40"
>
> Can you please check comments in below link?
>
> https://lore.kernel.org/linux-f2fs-devel/8eaad9d0-1d59-3ecb-bab4-904ed223=
85f4@kernel.org/
>
Thanks for your share and I got it.
> Thanks,
>
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/checkpoint.c | 2 +-
> >   fs/f2fs/segment.c    | 4 ++--
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index b0597a5..f6a5424 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1893,7 +1893,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *s=
bi)
> >               return 0;
> >
> >       cprc->f2fs_issue_ckpt =3D kthread_run(issue_checkpoint_thread, sb=
i,
> > -                     "f2fs_ckpt-%u:%u", MAJOR(dev), MINOR(dev));
> > +                     "f2fs_cp-%u:%u", MAJOR(dev), MINOR(dev));
> >       if (IS_ERR(cprc->f2fs_issue_ckpt)) {
> >               int err =3D PTR_ERR(cprc->f2fs_issue_ckpt);
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index d05b416..b290713 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -677,7 +677,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_in=
fo *sbi)
> >
> >   init_thread:
> >       fcc->f2fs_issue_flush =3D kthread_run(issue_flush_thread, sbi,
> > -                             "f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev=
));
> > +                             "f2fs_fh-%u:%u", MAJOR(dev), MINOR(dev));
> >       if (IS_ERR(fcc->f2fs_issue_flush)) {
> >               int err =3D PTR_ERR(fcc->f2fs_issue_flush);
> >
> > @@ -2248,7 +2248,7 @@ int f2fs_start_discard_thread(struct f2fs_sb_info=
 *sbi)
> >               return 0;
> >
> >       dcc->f2fs_issue_discard =3D kthread_run(issue_discard_thread, sbi=
,
> > -                             "f2fs_discard-%u:%u", MAJOR(dev), MINOR(d=
ev));
> > +                             "f2fs_dc-%u:%u", MAJOR(dev), MINOR(dev));
> >       if (IS_ERR(dcc->f2fs_issue_discard)) {
> >               err =3D PTR_ERR(dcc->f2fs_issue_discard);
> >               dcc->f2fs_issue_discard =3D NULL;
