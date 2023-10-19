Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66D7D041C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbjJSVlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjJSVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:41:29 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE7BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:41:27 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6cd09663b1cso108851a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697751687; x=1698356487; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PmU2FKsnzb5ZXX3tTX1X2BdGNJX62qrZ4JKEx6OuTU=;
        b=RSQnSbxYRBuvXaoCQ01q3gCI2eff6kej2TWKpMIVlrXyEq54bGzPhXwaNDmrJrQ1T1
         7qTQxDu3kQ3s9a3fg6KEUUjmozjyE15xqzGpTgBUfQSea3d2xdoXDd87ThZGJd3OfuyH
         VMZL6SJBNIuOMOF3XD03Gmtw8BZ6fEgDemJnfaKE+uwTGRsrN4SbtikCgDaevsvC5Myv
         6dcImshVqSTSsNcSoYkn0mA81fucBcY7dwL1xzQcDlP+KkrSZwiAVwXhzuSsovpnpPDa
         SQ7k4PpzVlEtzgSe/hXF6rv5nKpMzYKUo3iiB6fHJDmW+XJAtinG3TRub+UEaGMZHa8N
         3w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697751687; x=1698356487;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PmU2FKsnzb5ZXX3tTX1X2BdGNJX62qrZ4JKEx6OuTU=;
        b=UonLR+c2QHSXT9cKwALO9I9U8E5VVblxoBv+7lCiZ6IcCwDYseVxXk+ZKmcvLBPYWV
         c5Sts94jENYb6I80ILBldf3ktoT1uscAF/QB5vf+fHbrW/RZ5D7RLBsgjhY1V8fry2aK
         GM0cYmdZP2ecWp9T9kSEknaB5No7TCay8pu+qQHzSoHTtXCXzOJ7KQv40mT+QaAbRjhr
         IJJRfUiTnHvdnqpmKOcgesXjropxbzi2rDaC2fxbVtUhCGMMAXf01EhJqrYy6vX8u0y4
         DpK4DP8nAPEl2FNc8Ki9+4XrbQ7aT7PEF2cbS3dtO6AovZjW7Eo34VYiu9fK1I29bBSh
         Pjqw==
X-Gm-Message-State: AOJu0YxNOvgrQpyb5sngl+Xq6HmNAQaiqq3ayes51d5Mut8YvtAAJewW
        f0nVIQmjJjL/xeRk7zAgeSUHBA==
X-Google-Smtp-Source: AGHT+IGPG6w5SHcB8Fe6oTorM2i0pm9QlPdmNXgGhPxZK621WOn1cjYRCOOGGek68mhOHXfNeLdemw==
X-Received: by 2002:a05:6830:25d4:b0:6b8:f588:2c79 with SMTP id d20-20020a05683025d400b006b8f5882c79mr59079otu.1.1697751687063;
        Thu, 19 Oct 2023 14:41:27 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x19-20020a9d6293000000b006ce2c785ac7sm81812otk.8.2023.10.19.14.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:41:26 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 0/3] riscv: Add remaining module relocations and tests
Date:   Thu, 19 Oct 2023 14:41:23 -0700
Message-Id: <20231019-module_relocations-v6-0-94726e644321@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOiMWUC/23Q0WoDIRAF0F8JPneLOjpm+9T/KKHsOmMjJGvRR
 FrC/ntNKGUpPt5h5gzcmyicIxfxsruJzDWWmJYW8Gkn/HFaPniI1LLQUoMc5X44J7qe+D3zKfn
 p0rbLEBA8E1o1kxPt8DNziF8P9O3Q8jGWS8rfjx9V3ae/nIIeV9Ugh3kG2ht07EZ4zbGmEhf/7
 NNZ3MWq/xQlJXYV3RTjLKKxEJh8R4GNovoKNGVCdIFQOsVjRzFbxXUV05QRXLAcQGGQHcVulW7
 N1TaFAjNoMhT8/17Wdf0Bv9/ugM8BAAA=
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Emil Renner Berthing <kernel@esmil.dk>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of module relocations were missing, this patch includes the
remaining ones. I also wrote some test cases to ensure that module
loading works properly. Some relocations cannot be supported in the
kernel, these include the ones that rely on thread local storage and
dynamic linking.

ULEB128 handling is a bit special because SET and SUB relocations must
happen together, and SET must happen before SUB. A psABI proposal [1]
mandates that the first SET_ULEB128 that appears before a SUB_ULEB128
is the associated SET_ULEB128.

This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
RISCV_MODULE_LINKING_KUNIT.

[1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/403

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v6:
- Use (void *) instead of (u32 *) for handler type
- Constrain ULEB128 to be consecutive relocations
- Link to v5: https://lore.kernel.org/r/20231018-module_relocations-v5-0-dfee32d4dfc3@rivosinc.com

Changes in v5:
- Brought in patch by Emil and fixed it up to force little endian
- Fixed up issues with apply_r_riscv_32_pcrel_rela and
  apply_r_riscv_plt32_rela (Samuel)
- Added u8 cast in apply_r_riscv_sub6_rela (Andreas) 
- Link to v4: https://lore.kernel.org/r/20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com

Changes in v4:
- Complete removal of R_RISCV_RVC_LUI
- Fix bug in R_RISCV_SUB6 linking
- Only build ULEB128 tests if supported by toolchain
- Link to v3: https://lore.kernel.org/r/20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com

Changes in v3:
- Add prototypes to test_module_linking_main as recommended by intel
  zero day bot
- Improve efficiency of ULEB128 pair matching
- Link to v2: https://lore.kernel.org/r/20231006-module_relocations-v2-0-47566453fedc@rivosinc.com

Changes in v2:
- Added ULEB128 relocations
- Link to v1: https://lore.kernel.org/r/20230913-module_relocations-v1-0-bb3d8467e793@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Add remaining module relocations
      riscv: Add tests for riscv module loading

Emil Renner Berthing (1):
      riscv: Avoid unaligned access when relocating modules

 arch/riscv/Kconfig.debug                           |   1 +
 arch/riscv/include/uapi/asm/elf.h                  |   5 +-
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/module.c                         | 368 +++++++++++++++------
 arch/riscv/kernel/tests/Kconfig.debug              |  35 ++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 +
 .../tests/module_test/test_module_linking_main.c   |  85 +++++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 ++
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 ++
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 ++
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 ++
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 ++
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 ++
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  20 ++
 18 files changed, 633 insertions(+), 102 deletions(-)
---
base-commit: 4d320c2d9a2b22f53523a1b012cda17a50220965
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

