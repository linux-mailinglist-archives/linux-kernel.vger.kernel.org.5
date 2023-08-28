Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4142878B237
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjH1NsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjH1Nrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:47:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751AA3;
        Mon, 28 Aug 2023 06:47:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so2793427b3a.0;
        Mon, 28 Aug 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230452; x=1693835252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZBQlPbR2a0P3y82rTwLQn3Av3wMDR+QWEG6E6jvnmY=;
        b=UrGZOnW2rGxGhoLuluZbWYrFfbeSXbDn28zrpW480W3Sxyy/khwBc10nBL2Aq5+KKb
         4dHUJSL11SaMtpOAj+DuHoQ1FPruUZlYkqJIuCAwEPj2Njm02O8MawfOtJkB951yweHC
         cRBp1G3ARz3z7kKxZJ3RMeuJVrJe2BPw/IcWCxMF8/CKTLXOq3yd4dCtFuTQsWE8UEnT
         egyBa2YX5cBktxsKNJxu2083H9UbOm+b2llXy/OV7aI/YVu5jzEwxliG6/KkFRS0pXbK
         WE25K4cR6bFBGgUeiGbR8kRI8dBD7l4S3Zi+J8xa4ozkg6WXBY7yVMJtqr6U9GX3LHcx
         dKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230452; x=1693835252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZBQlPbR2a0P3y82rTwLQn3Av3wMDR+QWEG6E6jvnmY=;
        b=PPpHKD6LvkYSbZNUHR4nWkV12UAfXD6CVoCignBS1EXrbcxHQNO7BAggWnXiXw7szu
         ce1EZPblyMCyIdpA1XMKLjNNtle6UNw/lyn2P7nWl174auS35VoRSSUKm1S8ie80EI+y
         xDHV09sQFkp9D5txOu6dnMdtq1yzY+sAuW3m2mU7jNfEJAFK6T5ee4rmD1jQmNrV3GHF
         UVtoZV538V8FA6OhDgLt1EfMfqFWNMZQ8batSpZ74vpwk8h5HhzCNZL113dqmmS2HO37
         p31doMJOtruvTwKMYaPfblFQewNWKH2dB8yXjggw1/lCXHh8vJzj7e4dNdOstj20f8Vt
         vntg==
X-Gm-Message-State: AOJu0YyZ6ZUAfM95IvZUvydjih9Qvq4J1yiAbFO0FBi71qYjCpnHu0KR
        z7UgnXZBiSjyp8UFC57uJ5lWeVvvOmBBpMV0
X-Google-Smtp-Source: AGHT+IEaLcPKtC0xcbuj/RTR092GXelufBWu9VT64v6sEyvE3+rM/ueRK5TxNWyFqTggNlsbdqW8QQ==
X-Received: by 2002:a05:6a20:4421:b0:140:22b0:9ddd with SMTP id ce33-20020a056a20442100b0014022b09dddmr35237603pzb.0.1693230452492;
        Mon, 28 Aug 2023 06:47:32 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id g20-20020a170902869400b001bbbbda70ccsm7336880plo.158.2023.08.28.06.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:47:32 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2] MIPS: loongson32: Remove dma.h and nand.h
Date:   Mon, 28 Aug 2023 21:47:25 +0800
Message-Id: <20230828134725.103442-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
unused platform devices"), struct plat_ls1x_dma and plat_ls1x_nand
are unused. Then, dma.h and nand.h are useless.
Therefore, remove these useless header files.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Remove include of dma.h and nand.h
          Update the commit message

 arch/mips/include/asm/mach-loongson32/dma.h  | 21 ----------------
 arch/mips/include/asm/mach-loongson32/nand.h | 26 --------------------
 arch/mips/loongson32/common/platform.c       |  2 --
 arch/mips/loongson32/ls1b/board.c            |  2 --
 4 files changed, 51 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h

diff --git a/arch/mips/include/asm/mach-loongson32/dma.h b/arch/mips/include/asm/mach-loongson32/dma.h
deleted file mode 100644
index e917b3ccb2c2..000000000000
--- a/arch/mips/include/asm/mach-loongson32/dma.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 NAND platform support.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_DMA_H
-#define __ASM_MACH_LOONGSON32_DMA_H
-
-#define LS1X_DMA_CHANNEL0	0
-#define LS1X_DMA_CHANNEL1	1
-#define LS1X_DMA_CHANNEL2	2
-
-struct plat_ls1x_dma {
-	int nr_channels;
-};
-
-extern struct plat_ls1x_dma ls1b_dma_pdata;
-
-#endif /* __ASM_MACH_LOONGSON32_DMA_H */
diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
deleted file mode 100644
index aaf5ed19d78d..000000000000
--- a/arch/mips/include/asm/mach-loongson32/nand.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 NAND platform support.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_NAND_H
-#define __ASM_MACH_LOONGSON32_NAND_H
-
-#include <linux/dmaengine.h>
-#include <linux/mtd/partitions.h>
-
-struct plat_ls1x_nand {
-	struct mtd_partition *parts;
-	unsigned int nr_parts;
-
-	int hold_cycle;
-	int wait_cycle;
-};
-
-extern struct plat_ls1x_nand ls1b_nand_pdata;
-
-bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
-
-#endif /* __ASM_MACH_LOONGSON32_NAND_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 8075590a9f83..623eb4bc7b41 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -15,8 +15,6 @@
 
 #include <platform.h>
 #include <loongson1.h>
-#include <dma.h>
-#include <nand.h>
 
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index fed8d432ef20..fe115bdcb22c 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -8,8 +8,6 @@
 #include <linux/sizes.h>
 
 #include <loongson1.h>
-#include <dma.h>
-#include <nand.h>
 #include <platform.h>
 
 static const struct gpio_led ls1x_gpio_leds[] __initconst = {

base-commit: be87eab1320e25c7d43cec7ee59bc607050abe85
-- 
2.39.2

