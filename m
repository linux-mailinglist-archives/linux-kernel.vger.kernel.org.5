Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C187F7A52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjKXR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKXR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:27:11 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C910E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:27:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so27137a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700846835; x=1701451635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voKJ3PYolsH2kKTHmf+m3gj4pWl9VQDRS+9wv0+naqU=;
        b=km8cf9k4kk1vPdOokFNlG+OpXTtu1SBkCcdLg8V5Zhd5x8hufrBuGPc8Al+qHwvj8Y
         HwU3nElOLI4+mku627yOHq5KnV+nuMIk0rS6SCOJXhMRshwBtbMXjAjajBjuajAolXxP
         qya3dGYNyPa0Dea480sQv1aejHDjXtS2ylhaSgFWp6RXojYtDgj4UjpKogRI/YUevk5H
         JtevwLpdCNI0FBZ6WSACVVA9ZC28iWYShAzFmEJTjPP1ZcqM9LvGo/NWkcYB1n8nplou
         egAM7RC37YPua30JeomPqgxsoJI//6kqmSZrIju0MBXoS7WqP8AopWgDa2145O1zQ4pA
         KcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846835; x=1701451635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voKJ3PYolsH2kKTHmf+m3gj4pWl9VQDRS+9wv0+naqU=;
        b=dx9E60f9ZK7CC/VWtfVN0dGBOQ+DWj0VTClKHXJSYCedGlyTB9kJwNqTQZsvv5kvli
         qM6KHvojGnUTOaFdvW6K/dY8FMr/IqIKTzcNNgGNzHNULi2DLnoF/L6Qpi2EZaHjA6qo
         nezF02DMWHFyZNPHGiQ6sY//wxVbn646d21kNDYTiNFuqsgkRWMOj5L85qNcb5AZtusJ
         P24pA3zb01hxlEJJ1dZoSTNr0m01ATCEQbIK0XQzMTNPGL6sAyUpW3ek9iGQMEEPALm4
         cGVvVoemZ1yp/7CNvCernThlctiXde8S3c2YM3ezKCGJxBeViLyJMolSi7V8lOv0OgR2
         SyXg==
X-Gm-Message-State: AOJu0YwZMUsipEh+DMxxhBgMEsouB80MScXDhP6rr0Tg36no2WA9uEpq
        Ifo16hzs/Iebcn9MlGl+nSbdAknairyUaPAaPiFjYw==
X-Google-Smtp-Source: AGHT+IG5wDUCEf6zix84IkqiNQHogSuRdDvjcL0/ZDM9Ke9K+pBdLBzocPTX+8i4zxw0w9GmhgXE3BbfTC9iHzrBHcM=
X-Received: by 2002:a05:6402:291b:b0:54b:de2:2272 with SMTP id
 ee27-20020a056402291b00b0054b0de22272mr27917edb.7.1700846835369; Fri, 24 Nov
 2023 09:27:15 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cf908705eaa8c5a7@google.com> <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
 <20231124171707.GF18929@twin.jikos.cz>
In-Reply-To: <20231124171707.GF18929@twin.jikos.cz>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Nov 2023 18:26:37 +0100
Message-ID: <CAG48ez0hPQciXnpK8M1wqcD5qfHGLDbqEvjYk4mLS6zN3BNR5g@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __kernel_write_iter
To:     dsterba@suse.cz
Cc:     syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 6:24=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
> On Fri, Nov 24, 2023 at 05:21:20PM +0100, Jann Horn wrote:
> > On Mon, Oct 10, 2022 at 9:04=E2=80=AFAM syzbot
> > <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com> wrote:
> > > HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.li=
naro...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D110f6f0a8=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd19f5d167=
83f901
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D12e098239d2=
0385264d3
> > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71=
c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9=
/disk-a6afa419.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vm=
linux-a6afa419.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 20347 at fs/read_write.c:504 __kernel_write_iter=
+0x639/0x740
> > [...]
> > >  __kernel_write fs/read_write.c:537 [inline]
> > >  kernel_write+0x1c5/0x340 fs/read_write.c:558
> > >  write_buf fs/btrfs/send.c:590 [inline]
> > >  send_header fs/btrfs/send.c:708 [inline]
> > >  send_subvol+0x1a7/0x4b60 fs/btrfs/send.c:7648
> > >  btrfs_ioctl_send+0x1e34/0x2340 fs/btrfs/send.c:8014
> > >  _btrfs_ioctl_send+0x2e8/0x420 fs/btrfs/ioctl.c:5233
> > >  btrfs_ioctl+0x5eb/0xc10
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> >
> > The issue here is that BTRFS_IOC_SEND looks up an fd with fget() and
> > then writes into it with kernel_write(). Luckily the ioctl requires
> > CAP_SYS_ADMIN, and also Linux >=3D5.8 bails out on __kernel_write() on =
a
> > read-only file, so this has no security impact.
>
> I'm not sure if we could make the send ioctl safe for a non-root user,
> the code there has been doing tricks that have security implications.
>
> > I'm about to send a fix, let's have syzkaller check it beforehand:
> >
> > #syz test https://github.com/thejh/linux.git 573fd2562e0f
>
> The fix looks correct to me, thanks.

(I sent the fix to you and the other btrfs maintainers separately with
subject "[PATCH] btrfs: send: Ensure send_fd is writable", see
<https://lore.kernel.org/lkml/20231124164831.2191549-1-jannh@google.com/T/>=
.)
