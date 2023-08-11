Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0F77935D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjHKPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjHKPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:41:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC52127
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:41:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-268030e1be7so1298281a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691768495; x=1692373295;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw4ftXJ2pD7gGLErYxHz998AQHL6xNQLBAu5oya+NvU=;
        b=zEbwdSS2wkrwP9mGKV3WnaUubqdQt4lApqBzeDZvdb1WIialm9Qinnm3K5L2Kt4/pr
         DT+hmna9gc1Uvonk1/bx1hVTnDcnIgsjpfdpLcPEU7RMC71eif7uRnd0Y+0fhpsZd1Lc
         XzLukiIjjMmaS1mgr3JwENTQ9pgnJocazao/ITdIfNbEvkXnJgEyt4Mb+WTR3locYR/X
         0OxW1P4+U/lO1aDL4gJua1z8YxkwVNJeeq/scIc14ZJqggZ1gjgrza452lpRBr02Xt2H
         u4W4Ool+rsv8VVn/l8wdIu9Bun+lYjk918px7x1tg+V5yunUD6DWqtZtXgWt1ACKTBPs
         x/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691768495; x=1692373295;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw4ftXJ2pD7gGLErYxHz998AQHL6xNQLBAu5oya+NvU=;
        b=MAch20FSLwap3Y5jttGO9Rxi6UOzw63/6JegtbPoZ35cKPXE23knY32gn6p6EmB247
         5cSmZNhK27yfIK4LGOelvZXl8Ua8VGNVxBIIugHy0YOmMi3nYjQf1gVtgJVTL3FcyWa+
         uEk26wvA8F1cfXuGGV7QJuchNo10tmfw3eXnljqu6Ldo6DNaHfu0EZAiwN5syO2TtD0G
         d1cD2S5Y27zp6Idl4/wbos0g5ewDaNX2JAYMIgvxT+pSX9xMA6uU/Ph4UOdY40jrBCkP
         BAntsVxEzbksPROU3dWY5bLG1DSHPbYGudISLTqTLmdt4L4mkFJZvbvpAcY7+OSpSBJP
         ML+A==
X-Gm-Message-State: AOJu0YwyBs6XZ0eXV1oqQNQnb+0mXCScys6LKu65yJK28waqtxTeKuDE
        MB0AYHdgI8a/p7DaZLy1X/jbtwFXaSe9RyFcx34=
X-Google-Smtp-Source: AGHT+IGW4jFihxb0fTb7T8n3ayIUPSgjpWAAmhdQNEVhbqIMTs/GW9ehVF3dqhnGNQJksoSVtD4xMw==
X-Received: by 2002:a17:90b:1982:b0:268:ac99:4bb4 with SMTP id mv2-20020a17090b198200b00268ac994bb4mr1524803pjb.46.1691768494664;
        Fri, 11 Aug 2023 08:41:34 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a005100b002609cadc56esm3705787pjb.11.2023.08.11.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:41:34 -0700 (PDT)
Date:   Fri, 11 Aug 2023 08:41:34 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Aug 2023 08:41:25 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.5-rc6
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c2fd272b-44d6-4174-9b97-3a253656e4ce@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 640c503d7dbd7d34a62099c933f4db0ed77ccbec:

  Documentation: kdump: Add va_kernel_pa_offset for RISCV64 (2023-08-02 13:50:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc6

for you to fetch changes up to 7e3811521dc3934e2ecae8458676fc4a1f62bf9f:

  riscv: Implement flush_cache_vmap() (2023-08-10 08:54:29 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.5-rc6

* Fixes for a pair of kexec_file_load() failures.
* A fix to ensure the direct mapping is PMD-aligned.
* A fix for CPU feature detection on SMP=n
* The MMIO ordering fences have been strengthened to ensure ordering
  WRT delay().
* Fixes for a pair of -Wmissing-variable-declarations warnings.
* A fix to avoid PUD mappings in vmap on sv39.
* flush_cache_vmap() now flushes the TLB to avoid issues on systems that
  cache invalid mappings.

----------------------------------------------------------------
Alexandre Ghiti (3):
      riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping
      riscv: Do not allow vmap pud mappings for 3-level page table
      riscv: Implement flush_cache_vmap()

Andrea Parri (1):
      riscv,mmio: Fix readX()-to-delay() ordering

Nick Desaulniers (1):
      riscv: mm: fix 2 instances of -Wmissing-variable-declarations

Palmer Dabbelt (1):
      Merge patch series "RISC-V: Fix a few kexec_file_load(2) failures"

Samuel Holland (1):
      riscv: Fix CPU feature detection with SMP disabled

Torsten Duwe (2):
      riscv/kexec: handle R_RISCV_CALL_PLT relocation type
      riscv/kexec: load initrd high in available memory

 arch/riscv/include/asm/cacheflush.h |  4 ++++
 arch/riscv/include/asm/mmio.h       | 16 ++++++++--------
 arch/riscv/include/asm/pgtable.h    |  2 ++
 arch/riscv/include/asm/vmalloc.h    |  4 +++-
 arch/riscv/kernel/cpu.c             |  5 +++++
 arch/riscv/kernel/elf_kexec.c       |  3 ++-
 arch/riscv/kernel/smp.c             |  5 -----
 arch/riscv/mm/init.c                | 16 +++++++++++-----
 arch/riscv/mm/kasan_init.c          |  1 -
 9 files changed, 35 insertions(+), 21 deletions(-)
