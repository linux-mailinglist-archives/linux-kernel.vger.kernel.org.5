Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E27B8349
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbjJDPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjJDPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E32BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4064e3c7c07so3944295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432463; x=1697037263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiCOeJRANpJ7P0MWtYGhVQpvoxCcQmfg9ZQBftOdf3o=;
        b=YDcJQjlc8TQtLa4rQFfTWQvS0YD8v9ghEAh0j8DTyF9Oqh3BxcNK4rsw6u1QKZ1S4B
         6JrPlCin/RuXJdzJHQ8vE1gBp8Qabx8nw/w2VilMCXUEzO9OXUnWACCqoU7N+yUkDL2Z
         jsf6BV3zig6wFsuNQFMjpgTbXy2gmOCPYU5hThnJv+PKs51WFvEQgBUyhgMs6GKaakgq
         QI5pxWAwzNr8J6Q+HhVCXnwxFX89+bScJTHQF21V62MbW5zx3mEI5O6PPmCJFVaOZ6RZ
         O8of3EkaaX8ckIei38gJgfIjxL1L8CGVQPJ4jYfOFGRNfWnhW91UYKPvCD0R1uJtNBFv
         83zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432463; x=1697037263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiCOeJRANpJ7P0MWtYGhVQpvoxCcQmfg9ZQBftOdf3o=;
        b=tGZtMj4ANQ52se+ho9HX2SelfP3eOUYxjVcq1bhslIyXx57QwWiR+lWIaaOE2BL1g4
         dmWNMZvCYOAD7lo9e14wWoZkhXIVi1hSSs4VQT2tHedjYJDuhWkqsJLbcxhID4fQvARi
         cdRGhoNhw4L6a6hSxAJ27ebeMFOHvi+OFQc8o9oA/XOGD3W3FvT5DLNc4DdiOVhy3Kw5
         VYJxZDmIGONDct0QxXAe+8sA/GMJVYcMi+hM8Ym9/Mt2duoRNY+XCdJyvPUu/6kRlFBg
         ID8xwUG5q2UQiSSzXby34ZeeiC7sn7D48CLsL2IEqEC8PTS3Z7uZ/1NQNwUP4uDqJ4vE
         qRPQ==
X-Gm-Message-State: AOJu0Yz741ZWPFABt8+MCm6eGMuX4yuifpn6VAKwmZTftRiEFRQqh4ai
        N1B1+wFbZfouCYovr98hvLvJwpqrscs7WuHYeSPOyg==
X-Google-Smtp-Source: AGHT+IEFRogL8GkogCVx+tQlnbmJpQqHe3HYjESa17xIS+381kk34vs7TYN2Mj5VcrnAg/SFSwdoNg==
X-Received: by 2002:a05:600c:1d03:b0:405:39bb:38a8 with SMTP id l3-20020a05600c1d0300b0040539bb38a8mr2507039wms.2.1696432462551;
        Wed, 04 Oct 2023 08:14:22 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:21 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 0/8] Add support to handle misaligned accesses in S-mode
Date:   Wed,  4 Oct 2023 17:13:57 +0200
Message-ID: <20231004151405.521596-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 61cadb9 ("Provide new description of misaligned load/store
behavior compatible with privileged architecture.") in the RISC-V ISA
manual, it is stated that misaligned load/store might not be supported.
However, the RISC-V kernel uABI describes that misaligned accesses are
supported. In order to support that, this series adds support for S-mode
handling of misaligned accesses as well support for prctl(PR_UNALIGN).

Handling misaligned access in kernel allows for a finer grain control
of the misaligned accesses behavior, and thanks to the prctl() call,
can allow disabling misaligned access emulation to generate SIGBUS. User
space can then optimize its software by removing such access based on
SIGBUS generation.

This series is useful when using a SBI implementation that does not
handle misaligned traps as well as detecting misaligned accesses
generated by userspace application using the prctrl(PR_SET_UNALIGN)
feature.

This series can be tested using the spike simulator[1] and a modified
openSBI version[2] which allows to always delegate misaligned load/store to
S-mode. A test[3] that exercise various instructions/registers can be
executed to verify the unaligned access support.

[1] https://github.com/riscv-software-src/riscv-isa-sim
[2] https://github.com/rivosinc/opensbi/tree/dev/cleger/no_misaligned
[3] https://github.com/clementleger/unaligned_test

Changes in V2:
 - Fix wrong fpu assembly function name (detected with llvm build)
 - Changes the detection mechanism using direct detection in trap handler
   (CONFIG_M_MODE does not support extable and re-adding extable just
    for some boot time detection is a bit overkill)
 - Fix commit order (used a variable introduce in a later commit)
 - Add a CONFIG_RISCV_MISALIGNED option to completely disable misaligned
   handling in kernel and reduce text size
 - Use for_each_present_cpu() instead of for_each_possible_cpu() in init
 - Ensure that if unaligned_ctl was set, fail to online cpu if it does
   not emulate misaligned accesses.

Clément Léger (8):
  riscv: remove unused functions in traps_misaligned.c
  riscv: add support for misaligned trap handling in S-mode
  riscv: report perf event for misaligned fault
  riscv: add floating point insn support to misaligned access emulation
  riscv: add support for sysctl unaligned_enabled control
  riscv: annotate check_unaligned_access_boot_cpu() with __init
  riscv: report misaligned accesses emulation to hwprobe
  riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN

 arch/riscv/Kconfig                    |   9 +
 arch/riscv/include/asm/cpufeature.h   |  18 ++
 arch/riscv/include/asm/entry-common.h |  14 +
 arch/riscv/include/asm/processor.h    |   9 +
 arch/riscv/kernel/Makefile            |   2 +-
 arch/riscv/kernel/cpufeature.c        |   6 +-
 arch/riscv/kernel/fpu.S               | 121 +++++++++
 arch/riscv/kernel/process.c           |  18 ++
 arch/riscv/kernel/smpboot.c           |   2 +-
 arch/riscv/kernel/traps.c             |   9 -
 arch/riscv/kernel/traps_misaligned.c  | 375 ++++++++++++++++++++++----
 11 files changed, 524 insertions(+), 59 deletions(-)

-- 
2.42.0

