Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C776477D060
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjHOQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbjHOQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672EA1B2;
        Tue, 15 Aug 2023 09:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1AA63255;
        Tue, 15 Aug 2023 16:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57151C433C7;
        Tue, 15 Aug 2023 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692118312;
        bh=ssLJkFs+vvhZqPWeXoLe5+bSo06CfEhsFqoZxkMOeLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ip9tVy/R+N9x3W2/eTJf/C/YewObmpsK7b0qDyrw6NyFSaaJzC85/GyTYwKcAei5r
         nkmy5kwdL7gPBmrn+4Ue2uoUIfhZADsKHYDtTMlYyCxE2ZWPM72FFyjzbhuDWCQugQ
         Y5Q+5GPf86oJ+Hmv10jvpqPKP6kAYGOLiuBeZuq6thyxnQ76pkQqklkCo6tG0/HqWz
         jWocvdPtpf37QPTNp3ila+5pLX7Gx8MFCj/fRNEcl/Bj4kkvdfUrngX21enrZ2jv84
         TJSLVfMd589cfCeIq8961OmKjBiOastIgQhZ6SZA7yUqU1txzigp6R1kLTQuOXTfNE
         cVxTEpS4ifeew==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe934c4decso8057823e87.1;
        Tue, 15 Aug 2023 09:51:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YyNrsSYNToXPrxSkHFGlZAvUtX/p2PzTQwx9jpVnLXckf+4VDzX
        JWvDG2KOEUqWB0olKYfOi31FjEvgrJidNdwCdUU=
X-Google-Smtp-Source: AGHT+IFFVgFgA8pSXPNG34hDDVrkKSlykdFfHwrJeqXL0EBNa3zJqNOBuDAzuGTLytPdWyS3ZYiCxqzLP8CqA95R0cE=
X-Received: by 2002:a05:6512:3a8f:b0:4f8:5e65:b61b with SMTP id
 q15-20020a0565123a8f00b004f85e65b61bmr5578659lfu.65.1692118310366; Tue, 15
 Aug 2023 09:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230815091931.4dd2b277@canb.auug.org.au> <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
 <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk> <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
 <48f834c2-b283-4b02-9407-4a0842d4ed72@kernel.dk> <CAPhsuW4YNWksHgTZGzX8Rj1+gU-aqQjiYueNRNHPryxOk2WXqQ@mail.gmail.com>
 <a30e4e08-7b8c-498c-b8af-82262b3ec6ff@kernel.dk> <CAPhsuW5AHQkf6wO_4Z6VFbTCxNN9GchW_ZPxmC1vtc23ByPc6g@mail.gmail.com>
 <d7d2aea2-66e3-4172-8c04-f71dbe66612c@kernel.dk>
In-Reply-To: <d7d2aea2-66e3-4172-8c04-f71dbe66612c@kernel.dk>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Aug 2023 00:51:37 +0800
X-Gmail-Original-Message-ID: <CAPhsuW7AX-0JiycnaFHFHYWjWaGju-pXMJtrAFWYk62SkHk22w@mail.gmail.com>
Message-ID: <CAPhsuW7AX-0JiycnaFHFHYWjWaGju-pXMJtrAFWYk62SkHk22w@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:31=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 8/15/23 10:26 AM, Song Liu wrote:
> > On Wed, Aug 16, 2023 at 12:20?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 8/15/23 10:17 AM, Song Liu wrote:
> >>> On Wed, Aug 16, 2023 at 12:07?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 8/15/23 9:58 AM, Song Liu wrote:
> >>>>> On Tue, Aug 15, 2023 at 11:08?PM Jens Axboe <axboe@kernel.dk> wrote=
:
> >>>>>>
> >>>>>> On 8/14/23 9:21 PM, Yu Kuai wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> ? 2023/08/15 7:19, Stephen Rothwell ??:
> >>>>>>>> Hi all,
> >>>>>>>>
> >>>>>>>> In commit
> >>>>>>>>
> >>>>>>>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in ra=
id10_takeover()")
> >>>>>>>>
> >>>>>>>> Fixes tag
> >>>>>>>>
> >>>>>>>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
> >>>>>>>>
> >>>>>>>> has these problem(s):
> >>>>>>>>
> >>>>>>>>    - Target SHA1 does not exist
> >>>>>>>
> >>>>>>> Sorry about this, the commit was picked from previous md-next bra=
nch,
> >>>>>>> and I didn't know that it will change...
> >>>>>>
> >>>>>> It's most likely not your fault, I'm guessing Song rebased that br=
anch
> >>>>>> and this is why the sha changed. Song?
> >>>>>
> >>>>> Yeah, it is my fault. I am really sorry for this issue.
> >>>>>
> >>>>>>
> >>>>>>> Is there any way that I can fix this ?
> >>>>>>
> >>>>>> Only way to fix this is if I rewind my branch and Song updates his
> >>>>>> branch to not have this issue, and then sends a new pull request.
> >>>>>
> >>>>> Yes please. Let's fix this.
> >>>>
> >>>> Please send a new one, I've dropped the old one.
> >>>
> >>> Is this the for-6.6/block branch? I haven't seen the change yet. The =
top
> >>> commit on the branch (as I see) is
> >>>
> >>> 306d74055754 ("ublk: Switch to memdup_user_nul() helper")
> >>
> >> Where are you looking? It's at:
> >
> > I am looking at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >
> > It appears to be some lag from git server?
>
> That's just a backup, I always pull and push from git.kernel.dk. The
> korg one will lag about an hour, depending on when things are pushed.
> I've never used the korg one as the canonical location.

Got it. I will update my git config.

Here is the updated PR:


The following changes since commit 66a6a5d0ec852eaced589da066376e69397cd71e=
:

  ublk: Switch to memdup_user_nul() helper (2023-08-15 10:06:54 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git
tags/md-next-20230814-resend

for you to fetch changes up to 0d0bd28c500173bfca78aa840f8f36d261ef1765:

  md/raid5-cache: fix null-ptr-deref for r5l_flush_stripe_to_raid()
(2023-08-15 09:40:27 -0700)

----------------------------------------------------------------
Li Lingfeng (1):
      md: Hold mddev->reconfig_mutex when trying to get mddev->sync_thread

WANG Xuerui (5):
      raid6: remove the <linux/export.h> include from recov.c
      raid6: guard the tables.c include of <linux/export.h> with __KERNEL__
      raid6: test: cosmetic cleanups for the test Makefile
      raid6: test: make sure all intermediate and artifact files are .gitig=
nored
      raid6: test: only check for Altivec if building on powerpc hosts

Yu Kuai (3):
      md/raid5-cache: fix a deadlock in r5l_exit_log()
      md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()
      md/raid5-cache: fix null-ptr-deref for r5l_flush_stripe_to_raid()

Zhang Shurong (1):
      md: raid1: fix potential OOB in raid1_remove_disk()

 drivers/md/md-cluster.c   |  8 ++++----
 drivers/md/md.c           |  9 +++++----
 drivers/md/md.h           |  2 +-
 drivers/md/raid1.c        |  8 ++++++--
 drivers/md/raid10.c       |  3 +--
 drivers/md/raid5-cache.c  | 14 ++++++++------
 drivers/md/raid5.c        |  2 +-
 lib/raid6/mktables.c      |  2 ++
 lib/raid6/recov.c         |  1 -
 lib/raid6/test/.gitignore |  3 +++
 lib/raid6/test/Makefile   | 50
++++++++++++++++++++++++++------------------------
 11 files changed, 57 insertions(+), 45 deletions(-)
 create mode 100644 lib/raid6/test/.gitignore


Thanks,
Song
