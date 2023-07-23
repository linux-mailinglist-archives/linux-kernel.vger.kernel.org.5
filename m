Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1775E439
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWSvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 14:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWSvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 14:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2687DF3;
        Sun, 23 Jul 2023 11:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC88860E26;
        Sun, 23 Jul 2023 18:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15784C433C9;
        Sun, 23 Jul 2023 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690138297;
        bh=K5MA7Fk2+ObXwZvLoreYo8Ex71NIZz1A6wUqpOMZEEU=;
        h=From:Date:Subject:To:Cc:From;
        b=TB2mRwAzlmivy4jn5yj90bWCFhOGclyyOwZgONcchrUCR45TQX2RddqvYM1kO2mjt
         DyTM/9x3uacipR4mdHpXUQEqyXG0Y1bKqfJ3RnrEafFZrvE2qRxEQbSuxfvb7kT52M
         x3R9Z/A4bsgSz1+CbTVZ3r88jxRL+UPvO7a7XKDlztpSf7RfgZMUurJuWaDnCS539B
         JmDu/eUut3kwcbUbx1XTcSKBc11jTFj8ka+36GkJJL9vTEmoTHZU0EdD+QZNH0tpDX
         vdD04R20CTJNSw0IgyaLV78OXI7NVAcFmdd5KFh7aZmzJAZMEduw1E34onqOJ1rMMk
         GWX+aU7Om07XQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5675add2980so2277535eaf.3;
        Sun, 23 Jul 2023 11:51:37 -0700 (PDT)
X-Gm-Message-State: ABy/qLa0pKNvArA5po+PeiVRAGZN9X/dHwEis8m56z9Nom5hN3uLB1an
        LnsorYAE04ajDf/ez0XZ/mbusHozjbB5uj1RrCU=
X-Google-Smtp-Source: APBJJlGn4yxFMpSTSfuvmgu0fHAaNp9KaNvlPrFnP/okeYVBQ02AP5Dw4xZzo/MXiCv0xfbjy3/RwCc/+9e4pkKuiAU=
X-Received: by 2002:a4a:d2cd:0:b0:567:95:a0e5 with SMTP id j13-20020a4ad2cd000000b005670095a0e5mr6244951oos.0.1690138296328;
 Sun, 23 Jul 2023 11:51:36 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 24 Jul 2023 03:51:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7+XWY8Vy4Hfst7DnpOwx3tnGpAbPTAojjzzH40+gDgQ@mail.gmail.com>
Message-ID: <CAK7LNAS7+XWY8Vy4Hfst7DnpOwx3tnGpAbPTAojjzzH40+gDgQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.5-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull some Kbuild fixes.

Thank you.



The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.5

for you to fetch changes up to df01b7cfcef08bf3fdcac2909d0e1910781d6bfd:

  kbuild: rust: avoid creating temporary files (2023-07-24 03:15:31 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.5

 - Fix stale help text in gconfig

 - Support *.S files in compile_commands.json

 - Flatten KBUILD_CFLAGS

 - Fix external module builds with Rust so that temporary files are
   created in the modules directories instead of the kernel tree

----------------------------------------------------------------
Alexey Dobriyan (1):
      kbuild: flatten KBUILD_CFLAGS

Benjamin Gray (1):
      gen_compile_commands: add assembly files to compilation database

Miguel Ojeda (1):
      kbuild: rust: avoid creating temporary files

Randy Dunlap (2):
      kconfig: gconfig: drop the Show Debug Info help text
      kconfig: gconfig: correct program name in help text

 Makefile                                    | 22 +++++++++++++++++-----
 scripts/Makefile.build                      |  5 ++++-
 scripts/Makefile.host                       |  6 +++++-
 scripts/clang-tools/gen_compile_commands.py |  2 +-
 scripts/kconfig/gconf.c                     | 11 ++++-------
 5 files changed, 31 insertions(+), 15 deletions(-)
