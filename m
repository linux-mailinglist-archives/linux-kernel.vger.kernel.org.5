Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1158E7DDC75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbjKAFnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345134AbjKAFnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:43:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D6DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:43:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5D1C433C7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698817395;
        bh=IxnoGrouf4tLsE/FNDB2eBhhoQZDmQenWAclQZeLKVs=;
        h=From:Date:Subject:To:Cc:From;
        b=FUrxfPLeaYpTMmrRZVxLax/hiYHEXBAnAGbL+hcMxKPGuhMJRU96r+ZAiB5SNO3JP
         4p1JLK01pSzm9SJ0VEuiSBQJpLm1rwxuFIqDcK+KQgOKQXrAVvfgMji+XTjzzyBQTL
         Qr/fLGe1ZpNUdl0FpIbBUitLfDuQw7MVzAraNB56NFW5pFhapNSJ5Ed7LdYG2YhIje
         YBKYEHwV6MeaKlQTvcl2Q2jc6gqkFX9B6pJEgbhfBJQeK+/o3xF9vi72s14xVtnVdK
         ZOiRtMJflqv3xxQS44Ux8ihAuXcyz8pkFth8WbSCsHaijclSq71VPCTdao0s5nwyda
         OcjCocaUOGTSg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c0b8f42409so4327800a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:43:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YzOlNxjYvU/YvwJnNALGq5TJCtvZ3EriUCrsETINNtsM8m5lreM
        Ek1WqviFCmcdiBuc+XQj95LDFHYtlHgOvqDunEk=
X-Google-Smtp-Source: AGHT+IFxYqd0gDZ0R6WZtZ2l7mql7rpV6kQUNvC9XSsSapBF5BqdLplewnoGo+nj3ma0VxWaI8iRCpb41oKe62fx6lw=
X-Received: by 2002:a05:6830:14:b0:6cc:fff0:8ebd with SMTP id
 c20-20020a056830001400b006ccfff08ebdmr14590646otp.24.1698817394315; Tue, 31
 Oct 2023 22:43:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5b46:0:b0:4fa:bc5a:10a5 with HTTP; Tue, 31 Oct 2023
 22:43:13 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 1 Nov 2023 14:43:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9qNaE+LACOh2nf04ua=M9UQZs2N=2uw8dFmKXPzkbxYA@mail.gmail.com>
Message-ID: <CAKYAXd9qNaE+LACOh2nf04ua=M9UQZs2N=2uw8dFmKXPzkbxYA@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v6.7-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit cd063c8b9e1e95560e90bac7816234d8b2ee2897:

  Merge tag 'objtool-core-2023-10-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-10-30
13:20:02 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.7-rc1

for you to fetch changes up to ee785c15b5906a69d4007b4754e8ae40fb41e0b4:

  exfat: support create zero-size directory (2023-10-31 10:01:45 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Add ioctls to get and set file attribute that used in fatattr util.
  - Add zero_size_dir mount option not to allocate a cluster when
creating directory.

----------------------------------------------------------------
Jan Cincera (1):
      exfat: add ioctls for accessing attributes

Yuezhang Mo (2):
      exfat: support handle zero-size directory
      exfat: support create zero-size directory

 fs/exfat/dir.c       | 20 +++++------
 fs/exfat/exfat_fs.h  | 14 ++++----
 fs/exfat/exfat_raw.h | 19 +++++-----
 fs/exfat/file.c      | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/exfat/inode.c     |  6 ++--
 fs/exfat/namei.c     | 52 +++++++++++++++++++---------
 fs/exfat/super.c     | 11 ++++--
 7 files changed, 171 insertions(+), 48 deletions(-)
