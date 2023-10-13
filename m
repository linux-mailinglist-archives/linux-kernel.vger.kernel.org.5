Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E447C8789
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJMOND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:13:02 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6606295
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:13:00 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4cbab83aaso1319671a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697206379; x=1697811179; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPn+q1R7Bbm5yJSzoIgb0X5A43/F3P8E+NQ5peN1/Dg=;
        b=VpZbvlUfW+/De4hotLFbq5n2XFZ591aglAxTousG1xYEvgM/GLZ4583Y27lp/r7+eY
         pE+S+E3H5dI0/V6fvcDXtumVTVGzzmN4aYCaFxkvMziV4MYMnYJVZyobKZDwR37nf0CK
         urfbXk8VfiQDPTQSE02VmcrDc3TiT52ugxMZpSLA0q2FHnMbX0O66yHwgx0lbvCDFAmC
         WZmQPR0RQydXPkM+kWcyICNzU8FWl7ZbnQkLDOTmq9mA/ADzntjHQQUqlQXX/ElWfmqV
         snmUTn+04zj6YgwLF8IBfhYyPH3uD2ao7lNqAijfABQRv123jErdwK4XMp51GFbe+j+T
         tMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206379; x=1697811179;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPn+q1R7Bbm5yJSzoIgb0X5A43/F3P8E+NQ5peN1/Dg=;
        b=GkWig39E5YPy3TgJGyEZ5sRHo9yAAnI5sHHvH60UKBtPnXsk15g3PUShKt1hsDatZW
         c8aQwwPIwPJKkfV5e3bTbKGQL82pk46qCiJkintqCRNsDXyfHJ0XJvha2Lza3uYAdKTe
         R/AToSKN0YDgsf+GDeEj78d/vm23SeCG5Q1AnNlUUXs/cDQZvam9wxdrKaMEVdDu2JoR
         UvySeqLiteKt88mxW26U3W0TkjcRBTE+gAv7mftPSlcZswOg6OmHNq1chTKM7vjTnWfp
         mVNQaAqhEvI40KMF9Z15url5r7DyG7+fWuD8nocGNFU6UaSxZQGTd8vmzxI46wsJSx/s
         QHBg==
X-Gm-Message-State: AOJu0YxSN96niVusb3P3vjUcpoKkZmrXuzo4kXY41SZmwW0bptwDGIN6
        yBd5AoxspE48HGT4mX4Fdmut5ocbNJymTiyCxo0=
X-Google-Smtp-Source: AGHT+IGjaH5gAMnjJYZcDnnbZPWXOMd/g1sjCPPaHBL5Q0i2BJH7JwFx/KWpisY+rq1cjDVa8fyBlg==
X-Received: by 2002:a05:6830:6a0c:b0:6ca:c677:4568 with SMTP id cz12-20020a0568306a0c00b006cac6774568mr7947800otb.10.1697206379633;
        Fri, 13 Oct 2023 07:12:59 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id g20-20020a9d6b14000000b006b9b0a08fdasm669812otp.59.2023.10.13.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:12:59 -0700 (PDT)
Date:   Fri, 13 Oct 2023 07:12:59 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Oct 2023 07:12:50 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.6-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-429a0f54-5269-417c-af90-7edef235cd7d@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8eb8fe67e2c84324398f5983c41b4f831d0705b3:

  riscv: errata: fix T-Head dcache.cva encoding (2023-09-12 13:58:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-rc6

for you to fetch changes up to 3fec323339a4a9801a54e8b282eb571965b67b23:

  drivers: perf: Fix panic in riscv SBI mmap support (2023-10-12 11:46:35 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.6-rc6

* A handful of build fixes.
* A fix to avoid mixing up user/kernel-mode breakpoints, which can
  manifest as a hang when mixing k/uprobes with other breakpoint
  sources.
* A fix to avoid double-allocting crash kernel memory.
* A fix for tracefs syscall name mangling, which was causing syscalls
  not to show up in tracefs.
* A fix to the perf driver to enable the hw events when selected, which
  can trigger a BUG on some userspace access patterns.

----------------------------------------------------------------
Sorry things were a bit slow for the last few weeks, I ended up getting COVID
at the Cauldron and thus have been a bit out of it.  So this is a bit big for
an rc6, but hopefully things are mostly back to normal for next week.

----------------------------------------------------------------
Alexandre Ghiti (3):
      riscv: kselftests: Fix mm build by removing testcases subdirectory
      riscv: Fix ftrace syscall handling which are now prefixed with __riscv_
      drivers: perf: Fix panic in riscv SBI mmap support

Andy Chiu (1):
      riscv: signal: fix sigaltstack frame size checking

Björn Töpel (1):
      riscv: Only consider swbp/ss handlers for correct privileged mode

Chen Jiahao (1):
      riscv: kdump: fix crashkernel reserving problem on RISC-V

Jiexun Wang (1):
      RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK

Lad Prabhakar (1):
      riscv: errata: andes: Makefile: Fix randconfig build issue

Song Shuai (1):
      riscv: Remove duplicate objcopy flag

 arch/riscv/Makefile                                |  1 -
 arch/riscv/errata/andes/Makefile                   |  4 ++++
 arch/riscv/include/asm/ftrace.h                    | 21 ++++++++++++++++
 arch/riscv/include/asm/kprobes.h                   | 11 ++++++++-
 arch/riscv/include/asm/uprobes.h                   | 13 +++++++++-
 arch/riscv/kernel/irq.c                            |  4 ++--
 arch/riscv/kernel/setup.c                          | 13 ----------
 arch/riscv/kernel/signal.c                         |  7 ------
 arch/riscv/kernel/traps.c                          | 28 ++++++++++++++--------
 drivers/perf/riscv_pmu.c                           |  3 ++-
 drivers/perf/riscv_pmu_sbi.c                       | 16 ++++++++-----
 tools/testing/selftests/riscv/mm/Makefile          |  6 ++---
 .../riscv/mm/{testcases => }/mmap_bottomup.c       |  2 +-
 .../riscv/mm/{testcases => }/mmap_default.c        |  2 +-
 .../selftests/riscv/mm/{testcases => }/mmap_test.h |  0
 .../selftests/riscv/mm/{testcases => }/run_mmap.sh |  0
 16 files changed, 84 insertions(+), 47 deletions(-)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_bottomup.c (97%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_default.c (97%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_test.h (100%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/run_mmap.sh (100%)
