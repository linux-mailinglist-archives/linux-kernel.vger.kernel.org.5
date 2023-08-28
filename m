Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEC78B8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjH1T7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjH1T6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:58:41 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB13189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56fb25fdf06so2248475a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693252718; x=1693857518;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbPpaVrfNq0ko2S3l1gP7OtKsP14DbcpFHAh7BgCC1A=;
        b=eee9/9wbtqwHBAG8KMk8MDEiwtL/oT3LgasRdCZtil3yifmuuVr59OGeOIdSHj+9oS
         8VJVtOskIxD4/MVztV31yHxshZsT1S7MCx+tbXjAiBskSK9KzPzp5q0DA869guvAOw7T
         ajEohkkAsS7Ny7SjIdGUPXSZqo8Lxm8JvEKLPeYK1Wnuu1mvI7VbpTL3UuN+E9/t2OEL
         3URtAnYPrYZADk8qJVa3283NQ+IZjtl/xHXXwxfYuYLzcoX6zUD5ZrGCy2iprPvmN5bO
         ITGZf5AeVuU8Yo6RCmdiNkfveD2V3fj/qlBdOTQMspt725YWRtOTftmseCE6fXN/bCzm
         9xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252718; x=1693857518;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbPpaVrfNq0ko2S3l1gP7OtKsP14DbcpFHAh7BgCC1A=;
        b=kY5d6y3Oy4c77vY/NpInreXxRedeYbuei45ZnnvXFweziRcgXgXrhg91wea7cV9+jn
         9UvPvkEUlPfyceKJb9DhMfmtXVadE0AytN7O/Mw55k1e+QHVm14iFw3OdVakhTcGr6zM
         dC0m4sDMniPQfODMKq6VLrNCA2M16oZKX9Kjt8b3DWh+RqSD7V7oQ4PMP31BSdvECJZt
         bpmt/VGPdIZ2t0kUx1RpciDAU1w8aiic9v9ydSGqxHEyuf3PYnPCLNJuuG0Od9UtW2qj
         5miscPeryW1wVLiHgPsMZ0vOl7W5vAXAnOVttPT0Mud/HkgRcSmAKbbYqcH9FcIvxw4Q
         xT6Q==
X-Gm-Message-State: AOJu0YxNlVGbDconb0RI+4pHnFCshloae9w3T4/otqZYddX9S3zS4ovC
        Z/C91/uXaNebbKSQ9UQ5XsjBJjw8qWeSRzP5HpE=
X-Google-Smtp-Source: AGHT+IHbkcWfdIY4Ud5PKH+QSr8+km87WDxWOUknjBIxSsOxtQJpHbg1H054vMbAlIhpwHOjgQSlqOs1z5/vUYrbGcU=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:7152:0:b0:564:9d36:f3e7 with SMTP
 id b18-20020a637152000000b005649d36f3e7mr4717640pgn.0.1693252718300; Mon, 28
 Aug 2023 12:58:38 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:58:34 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3616; i=samitolvanen@google.com;
 h=from:subject; bh=6Rvbx1308s+7tjXG2s5CV+7L4mBaZXiG3+xmk9JfTWk=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk7PxpRPNPxUPxFo8LuUUSU8wq4G9knMzw+k5NT
 rP4Eh7i+O2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZOz8aQAKCRBMtfaEi7xW
 7qOqC/9xZRZK4p72DZMfeemNtGJ0wu3AlDuvHcU9nb6515rZA6CCB9kkTr9cW2XxQdFjgs7+LX5
 7oRvgylRappXjS2xL1+AZN1P4mI6IzYodAqfdhYcPJkGIBGCuhMTiBJDeX6nEmsoh4iWNMigmF8
 lTnFcvlIKQRqDjA7F0D0U2grbN5rOKhB6LF39fUWb+5bnV8wOaJLHVPkTHkeed3dVYoDmL9oHrJ
 RzRbdWujvAvlZ+LhbNLAU3J7RdMK4IGQ0GBpZ9iKyQpDKUXRNi0T+ujnFcBrhnTtTiBRf5phOiJ
 csRN4iSoh5nVZjU7dSp0flwQn4sZJB4d2KVOBb2SlPmenP46w0D2AzyhTqsaawt4bfr38ZddmKT
 L18JQYdx5TumB0eiVGP7pau5qCS9oYHiJXqVNcNSdLJOKMVDhJGRuhL8tgFe86gqnt+j8PyB1H5 vAfXRF5EtLz11F7pQ1l1tKH4MML6ngObfGdKtA+8xUpVjOkX9Q65TTvcRJQpkCybhNztw=
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828195833.756747-8-samitolvanen@google.com>
Subject: [PATCH v3 0/6] riscv: SCS support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Clement Leger <cleger@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
rebased it and fixed a couple of minor issues. Patch 2 uses this
functionality to clean up the stack switching by moving duplicate
code into a single function. On RISC-V, the compiler uses the
gp register for storing the current shadow call stack pointer,
which is incompatible with global pointer relaxation. Patch 3
moves global pointer loading into a macro that can be easily
disabled with SCS. Patch 4 implements SCS register loading and
switching, and allows the feature to be enabled, and patch 5 adds
separate per-CPU IRQ shadow call stacks when CONFIG_IRQ_STACKS is
enabled. Patch 6 fixes the backward-edge CFI test in lkdtm for
RISC-V.

Note that this series requires Clang 17. Earlier Clang versions
support SCS on RISC-V, but use the x18 register instead of gp,
which isn't ideal. gcc has SCS support for arm64, but I'm not
aware of plans to support RISC-V. Once the Zicfiss extension is
ratified, it's probably preferable to use hardware-backed shadow
stacks instead of SCS on hardware that supports the extension,
and we may want to consider implementing CONFIG_DYNAMIC_SCS to
patch between the implementations at runtime (similarly to the
arm64 implementation, which switches to SCS when hardware PAC
support isn't available).

Sami

---

Changes in v3:
  - Dropped a now unneeded function declaration (patch 1).
  - Refactored call_on_irq_stack to use stack frame offsets
    based on Cl=C3=A9ment's suggestion (patch 2).
  - Rebased on top of v6.5.

Changes in v2:
  - Fixed asm_per_cpu with !CONFIG_SMP (patch 1).
  - Added a fix to the CFI_BACKWARD lkdtm test (patch 6).
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

 arch/riscv/Kconfig                      |   6 ++
 arch/riscv/Makefile                     |   4 +
 arch/riscv/include/asm/asm-prototypes.h |   1 -
 arch/riscv/include/asm/asm.h            |  41 ++++++++
 arch/riscv/include/asm/irq_stack.h      |   3 +
 arch/riscv/include/asm/scs.h            |  54 +++++++++++
 arch/riscv/include/asm/thread_info.h    |  16 ++-
 arch/riscv/kernel/asm-offsets.c         |   9 ++
 arch/riscv/kernel/entry.S               | 124 ++++++++++++------------
 arch/riscv/kernel/head.S                |  19 ++--
 arch/riscv/kernel/irq.c                 |  56 +++++------
 arch/riscv/kernel/suspend_entry.S       |   5 +-
 arch/riscv/kernel/traps.c               |  68 +------------
 arch/riscv/kernel/vdso/Makefile         |   2 +-
 arch/riscv/purgatory/Makefile           |   4 +
 drivers/misc/lkdtm/cfi.c                |  13 ++-
 16 files changed, 248 insertions(+), 177 deletions(-)
 create mode 100644 arch/riscv/include/asm/scs.h


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
--=20
2.42.0.rc2.253.gd59a3bf2b4-goog

