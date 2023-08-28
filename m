Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C678AE91
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjH1LQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjH1LPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:15:53 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B47E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:15:49 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b3d7:dcc4:78fd:953])
        by xavier.telenet-ops.be with bizsmtp
        id ezFn2A00708ffG601zFnSj; Mon, 28 Aug 2023 13:15:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qaaDY-001tSI-NW;
        Mon, 28 Aug 2023 13:15:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qaYtS-00Cceq-JV;
        Mon, 28 Aug 2023 11:50:46 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.6
Date:   Mon, 28 Aug 2023 11:50:45 +0200
Message-Id: <20230828095045.3008527-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 922a9bd138101e3e5718f0f4d40dba68ef89bb43:

  m68k: Fix invalid .section syntax (2023-07-24 14:50:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.6-tag1

for you to fetch changes up to eb1e6ccdcf785e633863c5c7cec32d6c1e7b09dd:

  zorro: Include zorro.h in names.c (2023-08-21 13:27:44 +0200)

----------------------------------------------------------------
m68k updates for v6.6

  - Remove <asm/export.h>,
  - Miscellaneous W=1 fixes,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Arnd Bergmann (3):
      m68k: Define __div64_32() to avoid a warning
      m68k: Add memcmp() declaration
      zorro: Include zorro.h in names.c

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.5-rc1

Masahiro Yamada (2):
      m68k: Replace #include <asm/export.h> with #include <linux/export.h>
      m68k: Remove <asm/export.h>

 arch/m68k/configs/amiga_defconfig    | 2 +-
 arch/m68k/configs/apollo_defconfig   | 2 +-
 arch/m68k/configs/atari_defconfig    | 2 +-
 arch/m68k/configs/bvme6000_defconfig | 2 +-
 arch/m68k/configs/hp300_defconfig    | 2 +-
 arch/m68k/configs/mac_defconfig      | 2 +-
 arch/m68k/configs/multi_defconfig    | 2 +-
 arch/m68k/configs/mvme147_defconfig  | 2 +-
 arch/m68k/configs/mvme16x_defconfig  | 2 +-
 arch/m68k/configs/q40_defconfig      | 2 +-
 arch/m68k/configs/sun3_defconfig     | 2 +-
 arch/m68k/configs/sun3x_defconfig    | 2 +-
 arch/m68k/include/asm/Kbuild         | 1 -
 arch/m68k/include/asm/div64.h        | 3 +++
 arch/m68k/include/asm/string.h       | 1 +
 arch/m68k/lib/divsi3.S               | 2 +-
 arch/m68k/lib/modsi3.S               | 2 +-
 arch/m68k/lib/mulsi3.S               | 2 +-
 arch/m68k/lib/udivsi3.S              | 2 +-
 arch/m68k/lib/umodsi3.S              | 2 +-
 drivers/zorro/names.c                | 1 +
 21 files changed, 22 insertions(+), 18 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
