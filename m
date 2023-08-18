Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3D780C71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377094AbjHRNTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377079AbjHRNSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:18:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3A35AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:18:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6886d6895a9so774469b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692364727; x=1692969527;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbD3qI39lbOw6xxkLO7d3cqNPb86CrbmsEERY0HKJBM=;
        b=fb98EVQU18p4I1zlKBc/bdGKgp6zXHP8aOT1xj+RIHckZkwZhtwQ0g2/UptKUkV/BM
         84shHFq389pWSy83J6AH7o6PS5DPiUVHOT+LcYpE70NSVy1uvH02yFLBWvnLZPeC1Rg8
         INVFem78FhCaT+GD25Z099lk6txBxEjBkkqygscAc6kfqxxw4Wn1NURAx7CqdYkMxyUJ
         DDpe0wzYiioaVQ3IghdGWo53XT6ooIMQuThImYo73w6Jf1Nl6/lJQr9tq30OWOcyl8aB
         m1qXu0glAm+K9vQ3NjgNxRJzVTOEtamjefQsmcfun/HZeVNKi3sv/BqFaudEpwmCYIkR
         hDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692364727; x=1692969527;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbD3qI39lbOw6xxkLO7d3cqNPb86CrbmsEERY0HKJBM=;
        b=cP3hdi4sc9L1azp4Yb0ph2WcukUZ75Ouv0qZCm/R9cum5GSHshHFjuqpnTiLlMNPQa
         Vj5iEvS8gvXiR522alciBJ5L7zJirk/JaH4FrqPaS5yGpb7uKFUVwyhdIjqxJJp7jZT5
         I29s9+jre1EowqsLwOW75El+DYSgfs1fFyQVMNSBndFr4L9O0OgQat7ULPmr2E0KELIq
         RDch9AAw882bLlV0k4iFMB1+z/UzC/8rdBgVMopv/uh1ve2Drg4gu7OyG3Gx2hJ2nTaj
         pMPqD4K6r4uXdOgULJmjD5zpA19Keg9f7MKRMb6w6CkW33dp4NqRR4IhLqlwqzsYb1Ru
         9vhQ==
X-Gm-Message-State: AOJu0YwOUHXVMisYlWC4aMVRUGr0iTZYadiV7qipSg/saC8hEwc37zbl
        FEFlFwJLOZrO6lCOtOKvzMiDoA==
X-Google-Smtp-Source: AGHT+IHoek2C14Iem4bCSW/tHEuu0KJ8jn0qnpFQM0qfV3FuQg0/LTwBzSAHXhsxBTjnvo06e+MqrQ==
X-Received: by 2002:a05:6a00:c89:b0:687:9a0b:9265 with SMTP id a9-20020a056a000c8900b006879a0b9265mr2861600pfv.29.1692364727053;
        Fri, 18 Aug 2023 06:18:47 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id v24-20020aa78098000000b006888029fd63sm1527580pff.9.2023.08.18.06.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:18:46 -0700 (PDT)
Date:   Fri, 18 Aug 2023 06:18:46 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Aug 2023 06:18:39 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.5-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e50f03c7-2a36-48e9-bda4-8f04ff461826@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e3811521dc3934e2ecae8458676fc4a1f62bf9f:

  riscv: Implement flush_cache_vmap() (2023-08-10 08:54:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc7

for you to fetch changes up to ca09f772cccaeec4cd05a21528c37a260aa2dd2c:

  riscv: Handle zicsr/zifencei issue between gcc and binutils (2023-08-16 07:39:38 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.5-rc7

* A fix to avoid excessive rejections from seccomp RET_ERRNO rules.
* A fix for compressed jal/jalr decoding.
* A pair of fixes for independent irq/softirq stacks on kernels built
  with CONFIG_FRAME_POINTER=n.
* A fix to avoid a hang handling uaccess fixups.
* Another build fix for toolchain ISA strings, this time for Zicsr and
  Zifenci on old GNU toolchains.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: uaccess: Return the number of bytes effectively not copied

Celeste Liu (1):
      riscv: entry: set a0 = -ENOSYS only when syscall != -1

Guo Ren (2):
      riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
      riscv: stack: Fixup independent softirq stack for CONFIG_FRAME_POINTER=n

Mingzheng Xing (1):
      riscv: Handle zicsr/zifencei issue between gcc and binutils

Nam Cao (1):
      riscv: correct riscv_insn_is_c_jr() and riscv_insn_is_c_jalr()

 arch/riscv/Kconfig                     | 32 +++++++++++++++++++-------------
 arch/riscv/include/asm/insn.h          | 15 +++++++++++++--
 arch/riscv/kernel/compat_vdso/Makefile |  8 +++++++-
 arch/riscv/kernel/irq.c                |  3 +++
 arch/riscv/kernel/traps.c              |  9 ++++++---
 arch/riscv/lib/uaccess.S               | 11 +++++++----
 6 files changed, 55 insertions(+), 23 deletions(-)
