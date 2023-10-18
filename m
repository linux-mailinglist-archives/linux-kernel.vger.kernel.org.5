Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666AF7CDC05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjJRMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjJRMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:40:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5895109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:40:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso3555528b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697632814; x=1698237614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/x3uu9zf3l2rig8KiIUkNU7Cv7Jr5Is7Qpx6yKtZAfw=;
        b=f4yws7udr4dhiWN6u8KB3P6yF1S5jAVjmD0YQtB+Pmg+Yx5/C7G7qiu3UFdL7gLLDO
         8NniZKYB5tUg1xGWYzjPaePhQuHmTZvSTJXA8nAkgNyAbb9FbfymuTnIg03u9CqBRI6F
         2hR2LJe0acpApgLqx2iwRh+F8Kw8ga1Oc8PgE0q0nTbRoK9CuwsUkY6rvcAVWc4hRkO5
         koFzjfF3i72fYVonL4AZACxzgGNxMmKz1RouwpTZ7eytGWt9rg7W2s1S99mCy2F7/81W
         SnS28PIiT8iBXz89v4GhnivslotW8moU7S5c9oEHKVGMV9CCLmqsJonU8g68ec1WYqX4
         O5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632814; x=1698237614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x3uu9zf3l2rig8KiIUkNU7Cv7Jr5Is7Qpx6yKtZAfw=;
        b=o1rUnO5hghEc0Gte2GqFN0rrZsKmmLzFSuH7d9WAJVWRwL7+raxwuXuwvKrN0sYo0s
         bNT1CnmIAt2nqG8d0Lm0KiNijhl4LcZMlVRT5Fwu/Eb/2eSG6WhP7QhFMOCYPBlfKBP6
         eu3UTmjPcDobYfVrkSmXsekfuXiD0r1QB00e0h6KfkLjF6+C1dzsN1bGiGmbaWmWBqhx
         eIc9trIXvy4YZYRPQW6cOIhfsO/66kRBEGUaSPM0WmVo/iYe+uyWnchTD/+93JTWnmeL
         X6MlUpC4giYk213MmRh5p0EIs9ziCh+3r/B+kQMwEk/Rz/DLqP3jI7TLd5UVWPyFnM7k
         Qzkg==
X-Gm-Message-State: AOJu0YyrWed7ftnGpHK2xOgjtWIA6IUX9w0H1kzwPdwwerwPRakvmMfA
        mBtFySQQdobY+Z1ZRziBAf1V3BmhPQMtY2qFZKA=
X-Google-Smtp-Source: AGHT+IGEnGeUGjTrjv2baYtR5a8vWsazPx3pLfK2Zn0Z8uBJVrUEphyrDMbgW79aJUk55uqnYKQ+WA==
X-Received: by 2002:a05:6a21:190:b0:149:700e:f50a with SMTP id le16-20020a056a21019000b00149700ef50amr8044741pzb.29.1697632813642;
        Wed, 18 Oct 2023 05:40:13 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id w190-20020a6382c7000000b005891f3af36asm1599267pgd.87.2023.10.18.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:40:13 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 -next 0/4] RISC-V: ACPI improvements
Date:   Wed, 18 Oct 2023 18:10:03 +0530
Message-Id: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a set of patches which were originally part of RFC v1 series
[1] to add ACPI support in RISC-V interrupt controllers. Since these
patches are independent of the interrupt controllers, creating this new
series which helps to merge instead of waiting for big series.

This set of patches primarily adds support below ECR [2] which is approved
by the ASWG and adds below features.

- Get CBO block sizes from RHCT on ACPI based systems.

Additionally, the series contains a patch to improve acpi_os_ioremap().

[1] - https://lore.kernel.org/lkml/20230803175202.3173957-1-sunilvl@ventanamicro.com/
[2] - https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view?usp=sharing

Changes since v3:
	1) Added new patch to update return value of acpi_get_rhct() as suggested by Drew.
	2) Formatting fixes as suggested by Drew.
	3) Updated tags.

Changes since v2:
	1) Modified acpi_get_cbo_block_size() not to take cpu parameter
	   but follow same pattern as DT (Feedback from Samuel and Drew)
	2) Dropped timer patch from the series since it is already
	   applied.
	3) Selected ARCH_KEEP_MEMBLOCK only if ACPI (Feedback from
	   Alex).
	4) Added RB tags received so far except RHCT patch which has
	   changed quite significantly from previous version.

Changes since RFC v1:
	1) Separated the patches from interrupt controller support series.
	2) Addressed feedback from Andy and Drew.
	3) Rebased to Palmer's for-next tree.
	4) Added RB tags received on RFC v1.


Sunil V L (4):
  RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
  RISC-V: ACPI: Update the return value of acpi_get_rhct()
  RISC-V: ACPI: RHCT: Add function to get CBO block sizes
  RISC-V: cacheflush: Initialize CBO variables on ACPI systems

 arch/riscv/Kconfig            |  1 +
 arch/riscv/include/asm/acpi.h |  6 +++
 arch/riscv/kernel/acpi.c      | 87 +++++++++++++++++++++++++++++++-
 arch/riscv/mm/cacheflush.c    | 25 +++++++---
 drivers/acpi/riscv/rhct.c     | 93 +++++++++++++++++++++++++++++++++--
 5 files changed, 201 insertions(+), 11 deletions(-)

-- 
2.39.2

