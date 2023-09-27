Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C297B0AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjI0RA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjI0RA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:00:26 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AFCDE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:24 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45270220069so4864788137.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834023; x=1696438823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lR0BPLKkgj2fJ5IyWi7flO/+WIQlLqax41QD5MIUKy0=;
        b=iih6pNLIRQUZMRqe3zrtvGPXNMlkAk7Rc6fRsmfK0AhRT5gg3kJcnaIx2g1Gvtw/+f
         0xG6mfTE+OhsDeHBFgXdEGijpgIei4p6gT11ktSATIElzKS0RdAv+QPMPv8XzspXkhn/
         pQoaVmrQtWZ11WRZvnNL8ZfxIQGRSZehYIkuh4CV6hjnIqPBFKdoncbzK4NvP3LZXZG6
         3vWasTAoj0c2oEh0DBXsJRKrJu0YKH0r1lkvCDtrFufuZ02Bz4V5AeVbJY9vHeOe52e8
         M0zD3cAOVVBIndccPmlbT3KLCGHR01ehPGj2HkYLUDh+YJPLoHh/H4MP6nhtwO+uYzV6
         oxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834023; x=1696438823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR0BPLKkgj2fJ5IyWi7flO/+WIQlLqax41QD5MIUKy0=;
        b=b3yFBJqwcUR8uLMehWMeqnf56MCm30MLTIe/P3AOWSRY+v4tEZcb0JfpoT13IOLiha
         f2uoN8gUhE3Dpm2X4aAPdO9azULj8UsxT16fjWyMuALM55KW7BYvSYmzm+pZ94IBdKxk
         zKQeWOKOuUE/dQd7NcIlqOQdGKTe+sspnFUVBcKnnYmNQTwDpMLaHctOKYiE5lmfubhc
         616Tf1JXQ01oetxrSzIB3maYwzAQZ0WATlNZxCZbHtmjb+y53m/1YV1xM1qX3LPoUuQK
         QGSmssQs2NSTZ8Gz8caTPY/FqgRgQiULGisw8y6X2lB1e/WWytuqJ7+ZSgecU5ro+or+
         APfA==
X-Gm-Message-State: AOJu0YwSV8mzokvMU5DKEn440gfYJU43UT1bosfj/G/Z2o6hlVRYKCgb
        6eZzvo4H/aATl8LMlRPELUmDwA==
X-Google-Smtp-Source: AGHT+IGbkNYcjY6OkDmHWUN+FpDde/aR1o0xZg9sHepbkCx/UdwSY0ITedw583PH98yPOZ8dUv5Kog==
X-Received: by 2002:a05:6102:f81:b0:452:de00:7ab4 with SMTP id e1-20020a0561020f8100b00452de007ab4mr1063401vsv.5.1695834023233;
        Wed, 27 Sep 2023 10:00:23 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:22 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 0/4] RISC-V: ACPI improvements
Date:   Wed, 27 Sep 2023 22:30:11 +0530
Message-Id: <20230927170015.295232-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
- Set timer_can_not_wakeup in timer driver based on the flag in RHCT.

Additionally, the series contains a patch to improve acpi_os_ioremap().

[1] - https://lore.kernel.org/lkml/20230803175202.3173957-1-sunilvl@ventanamicro.com/
[2] - https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view?usp=sharing

Changes since RFC v1:
	1) Separated the patches from interrupt controller support series.
	2) Addressed feedback from Andy and Drew.
	3) Rebased to Palmer's for-next tree.
	4) Added RB tags received on RFC v1.

Sunil V L (4):
  RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
  RISC-V: ACPI: RHCT: Add function to get CBO block sizes
  RISC-V: cacheflush: Initialize CBO variables on ACPI systems
  clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu

 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/acpi.h     |  9 ++++
 arch/riscv/kernel/acpi.c          | 87 ++++++++++++++++++++++++++++++-
 arch/riscv/mm/cacheflush.c        | 37 ++++++++++---
 drivers/acpi/riscv/rhct.c         | 72 ++++++++++++++++++++++++-
 drivers/clocksource/timer-riscv.c |  4 ++
 6 files changed, 201 insertions(+), 9 deletions(-)

-- 
2.39.2

