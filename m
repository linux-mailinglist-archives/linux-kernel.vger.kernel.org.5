Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145E17F0804
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjKSRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjKSRCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:02:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E24610C7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:01:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEEBC433C8;
        Sun, 19 Nov 2023 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700413312;
        bh=ru86jZzUfXNFF9k5YMUWNK9FW+jss64vTxKOc0+mVJU=;
        h=From:Date:Subject:To:Cc:From;
        b=F9k4pQWn5qkoUreZ0Qs9CZ6ToeOcPPP2m/9V4uFFx27K5EpcBfULGYwkIreFl+0PZ
         xhWULHTogo6igicxTSXY76dvNBDwVy4ZWU3daSJpaE0xmSbb05k7U/R4qREZdZsMt5
         JduZ/SzSBrWHRRIqpAzaJlYz0vVGpgjiiCegW38ci5+jYF+ycCfdFD8zV+CDpKj+Pk
         m1cvIVQBzLo7fMPmEfxcKJh47oh5oJp8RNAHUS6DQOoyxAhE6LU/ygJZXEaXl7116N
         Vtps5kguZKQMDLALV9MHG1vWPpAb6bn0TS7rytOuEAsGcEpub/WVnmq/UMCGy539m6
         IRsDf8O0pKkmg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f055438492so2126965fac.3;
        Sun, 19 Nov 2023 09:01:52 -0800 (PST)
X-Gm-Message-State: AOJu0Yx9muHM9KRnXIQ3BHKqRJy/tTgBKuPb02u1lAjaKdkDUVhtc3tQ
        4BMmX2zck3VR/htatJxUYehv/k0/Y1j4nMuDNNs=
X-Google-Smtp-Source: AGHT+IHl601uArgv5Eno1o3AqcocHQg4PeA8sFAei7ec30ZfwnTo+FZre9CdLIKejN84VYTzsUJ7nrvvbms5NnvM7sw=
X-Received: by 2002:a05:6870:f696:b0:1f5:cf0e:ea04 with SMTP id
 el22-20020a056870f69600b001f5cf0eea04mr5395796oab.58.1700413311348; Sun, 19
 Nov 2023 09:01:51 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Nov 2023 02:01:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATS=c2K7Ttg+Sb6gEmfUkrMbTQ0c62niOFzayzRF-rOdw@mail.gmail.com>
Message-ID: <CAK7LNATS=c2K7Ttg+Sb6gEmfUkrMbTQ0c62niOFzayzRF-rOdw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.7-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,


Please pull Kbuild fixes for v6.7-rc2.
Thanks.





The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.7

for you to fetch changes up to ae1eff0349f2e908fc083630e8441ea6dc434dc0:

  kconfig: fix memory leak from range properties (2023-11-17 13:24:08 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.7

 - Fix section mismatch warning messages for riscv and loongarch

 - Remove CONFIG_IA64 left-over from linux/export-internal.h

 - Fix the location of the quotes for UIMAGE_NAME

 - Fix a memory leak bug in Kconfig

----------------------------------------------------------------
Lukas Bulwahn (1):
      linux/export: clean up the IA-64 KSYM_FUNC macro

Masahiro Yamada (2):
      modpost: fix section mismatch message for RELA
      kconfig: fix memory leak from range properties

Simon Glass (1):
      kbuild: Move the single quotes for image name

 include/linux/export-internal.h |  4 +---
 scripts/Makefile.lib            |  4 ++--
 scripts/kconfig/symbol.c        | 14 ++++++--------
 scripts/mod/modpost.c           |  6 ++++--
 4 files changed, 13 insertions(+), 15 deletions(-)



--
Best Regards
Masahiro Yamada
