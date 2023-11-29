Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741C87FDBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbjK2Pss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbjK2Psq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:48:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B8410C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:48:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfaf05db73so223435ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701272931; x=1701877731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM0ns9BHLxfZ/kvsUGXQ6Hha2VKvW6930nLCCEsmbw0=;
        b=dsXFE1HF+tnRbe8kxB/4j8ADBKyQvtGzf8auD+wki3fGX2MH7Y7jN+0hmvvq7UEAQC
         b9Jta6K2ryBSsohUDXskRjdUk8InkB7WATEeXGVKEfPuWH+8UcORLcYFSyI+nnxoMDPQ
         G0imeYp510JBhTmL6zguQ75rrRDvBEwdfMtMByAyGloYln+Y71ddoqdc7xBwuGpgK53h
         jUJCpItseH+cl2/ytfYQMQkYs0Q4Jx4cCDzYngVkxA1LeYhBbSWHKifdVeRFRFGUreKe
         FFk6gh4eYybWXupYTtzsHkuhSdEww5Vm/hACTX9IDtitRfnkYJzlnWYgKCKuBxQqKqLU
         Caow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272931; x=1701877731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM0ns9BHLxfZ/kvsUGXQ6Hha2VKvW6930nLCCEsmbw0=;
        b=eM2ek5xQfMtHaMHoaFEqD+tx+EGumV1XYyaS8waAKFo3csoDhI9e/iNb9/1RROuo2N
         6I/OaHe948NqkSu3NAvsAq6y5dd23MgA73R5Av1kNM2C6TF065YQHLArFY8udwYdHf6I
         vw6QyWa+nGk4blemojlX9croXljFpTn4UzlqOP2Kne+49dHx+gnokJKMFF0q+mvnzI/q
         pT2CxcPvFPQPZlLi1Y1rUGfkH/uFNBts/EDNloQzmNhvU3xzJInm/PVVG4sPF1ofztk8
         HSgpo8ZW6SQuSM2n4W+eOwQy5J1kMNfwzfcq4wrK+4f975154mcD9kzkbdLxssZ/noPW
         g7+Q==
X-Gm-Message-State: AOJu0YzrB/sD/gxeRkTC633bYMv8DB5qHiGamGQ+OQ4glIAvUSPl/aCa
        oq2q2fzQ4IRX/OWpv07rxwPLxtgSf9gQdvtrHb4bPg==
X-Google-Smtp-Source: AGHT+IH7JoIl0dQ2yWOCAKQ8Oz6I5g2Tk3T/hoJUVzuZ2b+DJk+w8YGHIO2L0XM4tgMET2E7FfrpHfQa/Rz6UqJ6Nfs=
X-Received: by 2002:a17:902:c18b:b0:1cf:b2a9:fbf0 with SMTP id
 d11-20020a170902c18b00b001cfb2a9fbf0mr1030887pld.0.1701272929581; Wed, 29 Nov
 2023 07:48:49 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009401fb060b28a2e1@google.com> <CAKYAXd-WLUQcyMAWd_R4PKRcciRh=faNnixv38abWmj7V=To9Q@mail.gmail.com>
In-Reply-To: <CAKYAXd-WLUQcyMAWd_R4PKRcciRh=faNnixv38abWmj7V=To9Q@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 29 Nov 2023 16:48:35 +0100
Message-ID: <CANp29Y5e755ag+PFfqQZKrXozwF4dM_zo8fi_eNkNypeU_h1_w@mail.gmail.com>
Subject: Re: [syzbot] Monthly exfat report (Nov 2023)
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     syzbot <syzbot+listb51f932ee38ecac1b05d@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
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

Hi,

Thank you very much for taking a look at this report!

On Wed, Nov 29, 2023 at 3:10=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> 2023-11-28 6:03 GMT+09:00, syzbot
> <syzbot+listb51f932ee38ecac1b05d@syzkaller.appspotmail.com>:
> > Hello exfat maintainers/developers,
> Hi,
> >
> > This is a 31-day syzbot report for the exfat subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/exfat
> >
> > During the period, 1 new issues were detected and 0 were fixed.
> > In total, 7 issues are still open and 12 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 225     No    INFO: task hung in path_openat (7)
> There is no reproducer and I couldn't find where it is connected to exfat=
.
> >
> > https://syzkaller.appspot.com/bug?extid=3D950a0cdaa2fdd14f5bdc

Syzbot assigned exfat because of this report:
https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D10e02711680000

But it indeed does look like a false positive, let's update the subsystem.

#syz set <1> subsystems: fs

> > <2> 150     No    INFO: task hung in exfat_sync_fs
> There is no reproducer... Let me know how to reproduce it.

Syzbot has not yet found a reproducer for it, even though it does not
seem to be very rare (there've been already >150 such crashes).
There's a command to hide the finding from monthly reports if you
believe this is not actionable for you anyway.

> This can happen when disk speed is very low and a lot of writes occur.
> Is that so?
>
> >
> > https://syzkaller.appspot.com/bug?extid=3D205c2644abdff9d3f9fc
> > <3> 119     Yes   WARNING in drop_nlink (2)
> I'm curious how this issue was classified as an exfat issue.
> When looking at the backtrace, this issue appears to be an hfsplus issue.
>
>  hfsplus_unlink+0x3fe/0x790 fs/hfsplus/dir.c:381
>  hfsplus_rename+0xc8/0x1c0 fs/hfsplus/dir.c:547
>  vfs_rename+0xaba/0xde0 fs/namei.c:4844
> >
> > https://syzkaller.appspot.com/bug?extid=3D651ca866e5e2b4b5095b

This is triggered by both hfsplus and exfat mounts. See e.g. the crash
at "2023/06/20 03:21":
https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1248deff280000

> > <4> 38      Yes   INFO: task hung in exfat_write_inode
> I could not reproduce this by using C reproducer provided by you.
> Can you confirm that this really cannot be reproduced using it?
>
> >
> > https://syzkaller.appspot.com/bug?extid=3D2f73ed585f115e98aee8

I've followed the guide at [1] and the C reproducer crashed the VM in
~420 seconds with exactly the same output as on sykaller.appspot.com.

[1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#r=
un-a-c-reproducer

> > <5> 1       No    UBSAN: shift-out-of-bounds in exfat_fill_super (2)
> This is false alarm. ->sect_size_bits could not be greater than 12 by
> the check below.
>
>         /*
>          * sect_size_bits could be at least 9 and at most 12.
>          */
>         if (p_boot->sect_size_bits < EXFAT_MIN_SECT_SIZE_BITS ||
>             p_boot->sect_size_bits > EXFAT_MAX_SECT_SIZE_BITS) {
>                 exfat_err(sb, "bogus sector size bits : %u",
>                                 p_boot->sect_size_bits);
>                 return -EINVAL;
>         }
> >
> > https://syzkaller.appspot.com/bug?extid=3Dd33808a177641a02213e

Maybe something corrupts it in between the check and the use?
Syzkaller may generate a lot of situations when mount and other
operations on the same block device happen simultaneously.

There's a patch series[2] that helps prohibit this, but it has not yet
reached all trees we fuzz.

[2] https://lore.kernel.org/all/20231101173542.23597-1-jack@suse.cz/

--=20
Aleksandr
