Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F297F767B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjKXOi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjKXOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:38:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FA19A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:39:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so25014a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700836739; x=1701441539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qT9ijJ1bpTu4n/ZbJUawbOnA+vfnCrxXXqloSbnIeQ=;
        b=yDesW49T0+1evvm89TEnbWe/ZJLfnelZU76CL2gT+DrlXkFsU8RJ9HXX7T4xBS3nqG
         YWvsclM5ILHTglF4+l518OLadzDDUjzfi0cwS0+rRB+kzOrai1+Ovgyb3G5TJFIba6H1
         m9822nmo4TsdOkRtMaEfcpUlX1CgNMFRhmRNLpQsvNVrJjA/9hco8fRTkBs7v70cXe5r
         OjnqoxQ22Kdrr+091RVsrfNbDXrOrLgdhxYzn7a1MuSpkQ5lNR9UmGK5HBx90kGv72RW
         tX94HqQfSjb/6rLy7V6LkgrKhSNkA+Wlr+bv2DHqly7Xz3JUm71fCb3c4Cy++mbMmlfo
         T4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836739; x=1701441539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qT9ijJ1bpTu4n/ZbJUawbOnA+vfnCrxXXqloSbnIeQ=;
        b=VIZuUW4Mo1FeG2x4ZuHOd5VMF5U8W7N610726AUXziM5IDNBgJ9d169CL0cbyWGClF
         O98WG/5ulUUvnxCzniL8eMs0a6lAXpMyPItf2koMVpuUO+PHBedHSHyprxADw9VHfgBx
         XML/CzwNLx+TWNNU+z0T4qPjg/ME+KRTZzC7VieXNbl9Gyp3jlG3veMEoiZe5+g1xroH
         9mM5CQV9w2o+wkNhjWMHPZuIfgtQUvj31uUhrlYTjwPmZRLSMlYCivXVbF1cObuoAK5n
         YXgzyAK47dWwtVYSNKKE96K/bgzaH19/sW2imLqGKTqmUKwxpJkejzOh08SmpuAWBFJ1
         cgWw==
X-Gm-Message-State: AOJu0YxJeF3CnZfY4cB9jQVGRojWjBIBUEmg/pKPy9I084FncRbq/Eq/
        rHNIAtQHavtc9Xf77Y+Yp+tQJx5xj7S46m0QqYroDQ==
X-Google-Smtp-Source: AGHT+IEwCRCbej1gpkzx1rDgRxtOawzgZqRxAM9eZ4PKnqgFfodjGkhCziVIgeTfKfYyIu0AX68Mln+3VK3DNpzt/f4=
X-Received: by 2002:a05:6402:11c6:b0:54a:ee8b:7a8c with SMTP id
 j6-20020a05640211c600b0054aee8b7a8cmr102165edw.0.1700836738829; Fri, 24 Nov
 2023 06:38:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000778f1005dab1558e@google.com> <CAG48ez2AAk6JpZAA6GPVgvCmKimXHJXO906e=r=WGU06k=HB3A@mail.gmail.com>
 <1037989.1647878628@warthog.procyon.org.uk> <CAG48ez1+4dbZ9Vi8N4NKCtGwuXErkUs6bC=8Pf+6jiZbxrwR7g@mail.gmail.com>
In-Reply-To: <CAG48ez1+4dbZ9Vi8N4NKCtGwuXErkUs6bC=8Pf+6jiZbxrwR7g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Nov 2023 15:38:21 +0100
Message-ID: <CAG48ez3AazYzfJCFgu2MKSoxMEpJXz0td+rbeCOhsM38i78m3A@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in pipe_write
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

On Mon, Mar 21, 2022 at 5:17=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Mon, Mar 21, 2022 at 5:03 PM David Howells <dhowells@redhat.com> wrote=
:
> > Jann Horn <jannh@google.com> wrote:
> >
> > > The syz reproducer is:
> > >
> > > #{"threaded":true,"procs":1,"slowdown":1,"sandbox":"","close_fds":fal=
se}
> > > pipe(&(0x7f0000000240)=3D{<r0=3D>0xffffffffffffffff, <r1=3D>0xfffffff=
fffffffff})
> > > pipe2(&(0x7f00000001c0)=3D{0xffffffffffffffff, <r2=3D>0xfffffffffffff=
fff}, 0x80)
> > > splice(r0, 0x0, r2, 0x0, 0x1ff, 0x0)
> > > vmsplice(r1, &(0x7f00000006c0)=3D[{&(0x7f0000000080)=3D"b5", 0x1}], 0=
x1, 0x0)
> > >
> > > That 0x80 is O_NOTIFICATION_PIPE (=3D=3DO_EXCL).
> > >
> > > It looks like the bug is that when you try to splice between a normal
> > > pipe and a notification pipe, get_pipe_info(..., true) fails, so
> > > splice() falls back to treating the notification pipe like a normal
> > > pipe - so we end up in iter_file_splice_write(), which first locks th=
e
> > > input pipe, then calls vfs_iter_write(), which locks the output pipe.
> > >
> > > I think this probably (?) can't actually lead to deadlocks, since
> > > you'd need another way to nest locking a normal pipe into locking a
> > > watch_queue pipe, but the lockdep annotations don't make that clear.
> >
> > Is this then a bug/feature in iter_file_splice_write() rather than in t=
he
> > watch queue code, per se?
>
> I think at least when you call splice() on two normal pipes from
> userspace, it'll never go through this codepath for real pipes,
> because pipe-to-pipe splicing is special-cased? And sendfile() bails
> out in that case because pipes don't have a .splice_read() handler.
>
> And with notification pipes, we don't take that special path in
> splice(), and so we hit the lockdep warning. But I don't know whether
> that makes it the fault of notification pipes...
>
> Maybe it would be enough to just move the "if (pipe->watch_queue)"
> check in pipe_write() up above the __pipe_lock(pipe)?

[coming back to this thread 1.5 years later...]
I've turned that idea into a fix, let's have syzbot try it out before
I submit the fix patch:

#syz test: https://github.com/thejh/linux.git 56c486e68166
