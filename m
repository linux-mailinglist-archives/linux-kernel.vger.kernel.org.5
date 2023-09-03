Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B501790DA3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbjICTOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjICTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:14:01 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313BAB7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:13:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A43AF623488E;
        Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4suBvoeprK1D; Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 35E52623488F;
        Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ea5wIfuo781e; Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 175C0623488E;
        Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Date:   Sun, 3 Sep 2023 21:13:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML Changes for v6.6-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: ghDboZa1hFHmnDsq+KMITPB5MegcYA==
Thread-Topic: UML Changes for v6.6-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.6-rc1

for you to fetch changes up to 974b808d85abbc03c3914af63d60d5816aabf2ca:

  um: virt-pci: fix missing declaration warning (2023-08-26 22:49:49 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Drop 32-bit checksum implementation and re-use it from arch/x86
- String function cleanup
- Fixes for -Wmissing-variable-declarations and -Wmissing-prototypes builds

----------------------------------------------------------------
Azeem Shaikh (1):
      um: Remove strlcpy usage

David Gow (2):
      asm-generic: current: Don't include thread-info.h if building asm
      um: Use the x86 checksum implementation on 32-bit

Justin Stitt (2):
      um: vector: refactor deprecated strncpy
      um: Refactor deprecated strncpy to memcpy

Masahiro Yamada (2):
      um: Hard-code the result of 'uname -s'
      um: use obj-y to descend into arch/um/*/

Nick Desaulniers (3):
      uml: audio: fix -Wmissing-variable-declarations
      um: port_kern: fix -Wmissing-variable-declarations
      um: fix 3 instances of -Wmissing-prototypes

Randy Dunlap (1):
      um: Fix hostaudio build errors

Vincent Whitchurch (1):
      um: virt-pci: fix missing declaration warning

YueHaibing (1):
      um: Remove unsued extern declaration ldt_host_info()

 arch/um/Kbuild                    |   2 +
 arch/um/Makefile                  |   9 +-
 arch/um/configs/i386_defconfig    |   1 +
 arch/um/configs/x86_64_defconfig  |   1 +
 arch/um/drivers/Kconfig           |  16 +--
 arch/um/drivers/Makefile          |   2 +-
 arch/um/drivers/hostaudio_kern.c  |   2 +-
 arch/um/drivers/mconsole_kern.c   |   4 +-
 arch/um/drivers/port_kern.c       |   2 +-
 arch/um/drivers/slirp_kern.c      |   2 +-
 arch/um/drivers/vector_user.c     |   4 +-
 arch/um/drivers/virt-pci.c        |   2 +
 arch/um/drivers/xterm_kern.c      |   1 +
 arch/um/include/shared/irq_kern.h |   1 +
 arch/um/include/shared/user.h     |   1 -
 arch/um/kernel/irq.c              |   2 -
 arch/um/os-Linux/umid.c           |   6 +-
 arch/x86/um/Makefile              |   5 +-
 arch/x86/um/asm/mm_context.h      |   2 -
 arch/x86/um/checksum_32.S         | 214 --------------------------------------
 include/asm-generic/current.h     |   2 +
 sound/Kconfig                     |   2 +-
 22 files changed, 30 insertions(+), 253 deletions(-)
 delete mode 100644 arch/x86/um/checksum_32.S
