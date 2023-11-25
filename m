Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C97F8A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjKYLvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjKYLvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:51:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59711701
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:51:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so8114a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700913072; x=1701517872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSEpBwNYCgg88z1pn2eCQM4nuIQU17ETnUjE06VyojM=;
        b=YMhbw28ivea7RwLuaQ0iHal2IGiUjpktxHlUw/dmnLwUx1JYYiAKSIPQRI3PmMglLP
         QGfiXicH+jm9daH/PnYpMpK//wvWmyQkf+g8a/b3fRqbXQnpfVHyRVKzApXlvJkMTXEL
         198bnyBtzxDRCMrJZQzcZS/eij40GLgyVoiFRIlRUZXla+6IsZYjpZjNX0bQJQL7Hzwe
         ySisu0Te+eAtVuGYewkifCf1ib44Rg77vMktE9zgOLrRXFbqkK2OanpeuFH5i5+ZHEJi
         H7zHNg7ZFmwmO9drk5pO0Vm/3B6XQRFLzWoBfk+6olS3VLB0u5sQvKFC3kmbr9PhmbJp
         SEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700913072; x=1701517872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSEpBwNYCgg88z1pn2eCQM4nuIQU17ETnUjE06VyojM=;
        b=aHJkjk6Q+aAQE1UsHzM+D/qhUMumYxdvQzdtNppsQ6q9rmRa62ALP/Wlg5S8DLv4RJ
         ajnoosiXMw8CGKaBZ29lYDGwvAQasxz66isB+0jVh20stKpZCvbwty7GleUljysknNvb
         kj5GwKy8Pfqk0IOWqjXuXrcAK70GQLFKtNc4VSYxqx1bBl8NhlpSJDtT3kqXl/3LuKWq
         flx1ovInaSrbhwFkoyVB7GT00Pf9ovzp6gtvMNxgZzVbCJPctO++GxxibyznADoakCKp
         5N+Oici8vTFZctkVPWxF9SqBTJojTRQzI04sA0CnYcDkL7jUaw0sYEljonhVLkAKM40I
         6HIQ==
X-Gm-Message-State: AOJu0YzcKqzPoyaBKhbC4pu4r6bjfIsChzVlzK1wJ7CbSo8cFHXFuB2A
        RL+Be3vNPdZekeGUgnq93lWTte2zoD2xgDsXcyxWhA==
X-Google-Smtp-Source: AGHT+IGoe2yVXCakrbBcYSygUfnvoIydCcAi63CU/Fzkr87vR7R//qJFC1/czFU0zF9rWsFzx5EEC7O8YIc1PRg8pCo=
X-Received: by 2002:a05:6402:11c6:b0:54a:ee8b:7a99 with SMTP id
 j6-20020a05640211c600b0054aee8b7a99mr185429edw.0.1700913072223; Sat, 25 Nov
 2023 03:51:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjssgw1tZrUQvtHHVacSgR9NE0yF8DA3+R5LNFAocCvVQ@mail.gmail.com>
 <000000000000258ac60606589787@google.com> <CAG48ez2UkCR7LMaQfCQVLW4VOZG9CuPDMHG7cBtaAitM=zPBCg@mail.gmail.com>
 <CAG48ez2_XT1XDML756zM2D07BjcJnw22pFiHHrOm-yHvGJHvdw@mail.gmail.com> <CAOQ4uxj+enOZJiAJaCRnfb1soFS7aonJjHmLXiP3heQAFQoBqg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj+enOZJiAJaCRnfb1soFS7aonJjHmLXiP3heQAFQoBqg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 25 Nov 2023 12:50:36 +0100
Message-ID: <CAG48ez03BMw2EQq3Xjh4qn477V0qN1fG4M=8tO4EBsNTFD3wVQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
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

On Sat, Nov 25, 2023 at 10:21=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Nov 24, 2023 at 5:26=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Fri, Nov 24, 2023 at 4:11=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Wed, Sep 27, 2023 at 5:10=E2=80=AFPM syzbot
> > > <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com> wrote:
> > > > syzbot has tested the proposed patch and the reproducer did not tri=
gger any issue:
> > > >
> > > > Reported-and-tested-by: syzbot+477d8d8901756d1cbba1@syzkaller.appsp=
otmail.com
> > > >
> > > > Tested on:
> > > >
> > > > commit:         8e9b46c4 ovl: do not encode lower fh with upper sb_=
wri..
> > > > git tree:       https://github.com/amir73il/linux.git ovl_want_writ=
e
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d10ff=
a680000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb54ecd=
fa197f132
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D477d8d890=
1756d1cbba1
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > >
> > > It looks like the fix was submitted without the Reported-by tag, so
> > > syzkaller doesn't recognize that the fix has landed... I'll tell
> > > syzkaller now which commit the fix is supposed to be in, please
> > > correct me if this is wrong:
> > >
> > > #syz fix: ovl: do not encode lower fh with upper sb_writers held
> >
> > (Ah, and just for the record: I hadn't realized when writing this that
> > the fix was actually in a newer version of the same patch... "git
>
> That is correct.
> I am very thankful for syzbot with helping me catch bugs during developme=
nt
> and I would gladly attribute the bot and its owners, but I don't that
> Reported-and-tested-by is an adequate tag for a bug that never existed as
> far as git history.
>
> Even Tested-by: syzbot could be misleading to stable kernel bots
> that may conclude that the patch is a fix that needs to apply to stable.
>
> I am open to suggestions.
>
> Also maybe
>
> #syz correction:
>
> To tell syzbot we are not fixing a bug in upstream, but in a previous
> version of a patch that it had tested.

Sorry, I think I got that wrong; the syzbot manual
(https://github.com/google/syzkaller/blob/master/docs/syzbot.md#rebuilt-tre=
esamended-patches)
instead suggests:

"First, adding Reported-by tags to amended commits may be misleading.
A Reported-by tag suggests that the commit fixes a bug in some
previous commit, but here it's not the case (it only fixes a bug in a
previous version of itself which is not in the tree). In such case
it's recommended to include a Tested-by or a Reviewed-by tag with the
hash instead. Technically, syzbot accepts any tag, so With-inputs-from
would work too."

> > range-diff 44ef23e481b02df2f17599a24f81cf0045dc5256~1..44ef23e481b02df2=
f17599a24f81cf0045dc5256
> > 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77~1..5b02bfc1e7e3811c5bf7f0fa626=
a0694d0dbbd77"
> > shows an added "ovl_get_index_name", I guess that's the fix?)
>
> No, that added ovl_get_index_name() seems like a fluke of the range-diff =
tool.
> All the revisions of this patch always had this same minor change in this=
 line:

Ah, bleh, of course. I haven't used range-diff in a while and misread
the output...
