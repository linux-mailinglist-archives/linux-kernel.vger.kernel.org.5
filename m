Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11F777D434
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbjHOUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbjHOUet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:34:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4AF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d669fcad15cso5263208276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131687; x=1692736487;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vu3YlGSzqXzwwgWi/q2n2LUyYRgXMju9WJu57GL76pk=;
        b=20AONJpHkDmgRGgvrCxY0YZ8+qqnTitvPIFm7bIiayyUYFEQqFxqWYX8evjU2xIyUw
         kjDuIsOilMdRoalLKR77olLsbFjaAed3/7DHNZLY8sSj7RzpE3XHC1oIJpS5fO3DdjZs
         eGslVcDajvPI8Rde/nLOFVgo9XIrAhuny8kJs3Bti6SoSKx0omgX3hzEuQX36GvVbFff
         2deWtQZiWKLYyFOy6UiM2NxkHW3lvNnozvk+9w3XjLcmLksHncKXXh4v5EzHm4vLOyJc
         HBhwBE8ay/jX0hjbzZVvnLB1TnzbvlCw64myqkQrR1wHFoJU0qpNclkIh421HKlMKCTj
         foPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131687; x=1692736487;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vu3YlGSzqXzwwgWi/q2n2LUyYRgXMju9WJu57GL76pk=;
        b=aOMVIG3W1JhpLqTy9cnaCyP6eTbGKUYwpZQrFhOvmN28eRgQTWdhy7MwMNYhpcPPPi
         u9wVIQdTr4Ytj+wCBNpJVefML44QhT7bBihfZRJznOgsImwBrH4OMSZLMfdhvvtUSp99
         dHp1ABcRIp6GToMIvKGVYOpVP3OAn3PiIiZTdvnuVUIlgQXzEZWJRK/Ro4RGqV/sU0g8
         xK08Ur1dinASv2UdeOUnM5UpEJe1KPQpmP4XxCvarcCeHticV1rgzOHzs0CdsDcAc8hg
         6q6A6z7ZYkaQz71u3xGd/vNMvYgLM4LUC6WVUU7+aiqs4Q7f5oYkRjJ6dDC/MJbxaj0y
         B9kQ==
X-Gm-Message-State: AOJu0YzM8PVP1h9FiCaCWJ2b9Hvf6cYPRD9vlpiZ8zjGHuKrSYQqZe0j
        PaWbJ0NSZOxSklEPn1N0r+yLX/1jpck+G4WHpHk=
X-Google-Smtp-Source: AGHT+IEEEB9RkxNGC3nmjrLzfqaEjo04hgJYb9l9GY8BmhXIPcxgYphL1eVtvENoj53ebcdCaRYUhQD32EVakIpj8/M=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:565:b0:d18:73fc:40af with
 SMTP id a5-20020a056902056500b00d1873fc40afmr177279ybt.5.1692131686943; Tue,
 15 Aug 2023 13:34:46 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:34:43 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=samitolvanen@google.com;
 h=from:subject; bh=27ja0uIMORSaGulxExOcQfSpvjxiVAnXn8qbTbuF2b0=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk2+Fi/AuN72l+gcV8yqSSBdN3XwK5ap26p2ccW
 t4HA4fLgSGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZNvhYgAKCRBMtfaEi7xW
 7r6jC/sH51moOTq9GAgfZW4dtbVJIZrfYUSzK4jLvJmepsTXYq94/9JqoarL8IMhVnGC323YKZr
 E8A8U0U0WxapNQYW0Z0Q6wamv9b2xwueVG8zXctXXNPZsr8+jSzettmfIZjoB2uhItHSpHotq70
 iaOJ0gj83hEfx5sej+dGuPOo1tlpXxS1TYm7BVRz+7mAg8U1+4tFwVTi/22JzmAmvNwhc6YeEgX
 uE+/tftT10bAT8AEYZYiX3Q+MMBvT6cQtj5ybfDWHwHkd4hhWXNlIw9k+gaFc1L2/yoPx53SwS+
 ISUe54u+RjDb3YNfPy4JpwNdXcFQl3F3Aq7C0d2jI92BeRVINzB9MB1EtqPf01LvLnje/IhJJci
 ckDpO8njNWQ7J30a147p197hlPwd3LLqXp1YNxeBugtDRxtrbe9dAE1gUQJ3MbzGyhbJAmM5r3S /Li1U6ZyGOsoSDe2NClMgfhbi1GavCoEXC7ieC0iD4U6Oyxr4auvV2u+bGy0MWWimJbx8=
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815203442.1608773-8-samitolvanen@google.com>
Subject: [PATCH v2 0/6] riscv: SCS support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Guo Ren <guoren@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series adds Shadow Call Stack (SCS) support for RISC-V. SCS
uses compiler instrumentation to store return addresses in a
separate shadow stack to protect them against accidental or
malicious overwrites. More information about SCS can be found
here:

  https://clang.llvm.org/docs/ShadowCallStack.html

Patch 1 is from Deepak, and it simplifies VMAP_STACK overflow
handling by adding support for accessing per-CPU variables
directly in assembly. The patch is included in this series to
make IRQ stack switching cleaner with SCS, and I've simply
rebased it. Patch 2 uses this functionality to clean up the stack
switching by moving duplicate code into a single function. On
RISC-V, the compiler uses the gp register for storing the current
shadow call stack pointer, which is incompatible with global
pointer relaxation. Patch 3 moves global pointer loading into a
macro that can be easily disabled with SCS. Patch 4 implements
SCS register loading and switching, and allows the feature to be
enabled, and patch 5 adds separate per-CPU IRQ shadow call stacks
when CONFIG_IRQ_STACKS is enabled. Patch 6 fixes the backward-
edge CFI test in lkdtm for RISC-V.

Note that this series requires Clang 17. Earlier Clang versions
support SCS on RISC-V, but use the x18 register instead of gp,
which isn't ideal. gcc has SCS support for arm64, but I'm not
aware of plans to support RISC-V. Once the Zicfiss extension is
ratified, it's probably preferable to use hardware-backed shadow
stacks instead of SCS on hardware that supports the extension,
and we may want to consider implementing CONFIG_DYNAMIC_SCS to
patch between the implementation at runtime (similarly to the
arm64 implementation, which switches to SCS when hardware PAC
support isn't available).

Sami

---

Changes in v2:
  - Fixed asm_per_cpu with !CONFIG_SMP.
  - Added patch 6 to fix the CFI_BACKWARD lkdtm test.
  - Rebased on top of -rc6.

---

Deepak Gupta (1):
  riscv: VMAP_STACK overflow detection thread-safe

Sami Tolvanen (5):
  riscv: Deduplicate IRQ stack switching
  riscv: Move global pointer loading to a macro
  riscv: Implement Shadow Call Stack
  riscv: Use separate IRQ shadow call stacks
  lkdtm: Fix CFI_BACKWARD on RISC-V

 arch/riscv/Kconfig                   |   6 ++
 arch/riscv/Makefile                  |   4 +
 arch/riscv/include/asm/asm.h         |  41 +++++++++
 arch/riscv/include/asm/irq_stack.h   |   3 +
 arch/riscv/include/asm/scs.h         |  54 ++++++++++++
 arch/riscv/include/asm/thread_info.h |  16 +++-
 arch/riscv/kernel/asm-offsets.c      |   4 +
 arch/riscv/kernel/entry.S            | 126 +++++++++++++--------------
 arch/riscv/kernel/head.S             |  19 ++--
 arch/riscv/kernel/irq.c              |  53 ++++++-----
 arch/riscv/kernel/suspend_entry.S    |   5 +-
 arch/riscv/kernel/traps.c            |  65 ++------------
 arch/riscv/kernel/vdso/Makefile      |   2 +-
 arch/riscv/purgatory/Makefile        |   4 +
 drivers/misc/lkdtm/cfi.c             |  13 ++-
 15 files changed, 245 insertions(+), 170 deletions(-)
 create mode 100644 arch/riscv/include/asm/scs.h


base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.41.0.694.ge786442a9b-goog

