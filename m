Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A94578B14B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjH1NDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjH1NDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:03:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97155C9;
        Mon, 28 Aug 2023 06:02:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c576d35feso604040b3a.2;
        Mon, 28 Aug 2023 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693227752; x=1693832552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lgSWfpaRF1yioy+j4XYf+W7gMbc3i3wPgR9XqiIlfTs=;
        b=WrbZOPnto024zYz9HAnYGUCl2h/IJctd+asAS+ML5dU15+Z+00YvjRskIDtg9V6Q67
         ogywTEAmEQoxfQsNqbXxBWRFQXNuZ3Fy7C1XOl3c0R5x8Lpa7NlZTGTv3Ri6V67IGQ6t
         Xu3eIM7+nnZOTohVSUDqQBQ7REzRUV+MyxeNGkUL2idQjtgCQlBcj1V/OYJexSHTIOrZ
         BhS8hqscuqxpiu5hgaJPbjLVGyUKzECR3mN4+4FJPVpZYOkEbTsl2UVKoSv7gLFhbZr0
         y5n0bhsNDkQ+j995TfxM2q2bKg3Ci/R5ib/VyE6gg6FrDJbWo8CfoBPbLgjWqTmLeMnj
         8mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693227752; x=1693832552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgSWfpaRF1yioy+j4XYf+W7gMbc3i3wPgR9XqiIlfTs=;
        b=Fa7QdpWRDoKaxzusKxYUFwNe0QpfnbnThRcGkv0S0aDAv0jiXv3tRAcRuSq0ckTFwh
         6/JROgXViCTz1sPHb6ClZq4g44clxn/bspwrMdU7r+HO/y3JVdK1xm8fvdcPHfKpOVPR
         4/7dGGN/r55ik9R8eHzl1LHfdYqi1VsLMtkA7mNiUuaiRfQsGPJ5dGbGJKo6GXUVf+PX
         kXidJHVp+HRHHCfosHXVkHxmvB3qsdiZLYM/qrZ3YnRJO/0U0wiloW1G9SVKppDESsfE
         gwb+SCyF5pV90kTjrsbVvi/7fSszbU4ax1g1K1gxbVat12diJKbQexHF4fflgCtQiIz3
         4glA==
X-Gm-Message-State: AOJu0YyZtdjnNh8wKB8IwseQXkq2CpmMcYZfzvJVmboWbKwf88kbSlq+
        iGF0AM4P2EULc60iDx4s3SpZpKOkGsPUPL57
X-Google-Smtp-Source: AGHT+IHZpAgT28TJmdFViNy+mgLjEtTv1olUcbxMk/zOtplrtFIrVHOjvv7+EQDCzuBE57g5bKgvtw==
X-Received: by 2002:a05:6a20:9148:b0:126:af02:444e with SMTP id x8-20020a056a20914800b00126af02444emr31573733pzc.8.1693227751566;
        Mon, 28 Aug 2023 06:02:31 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00687087d8bc3sm6814199pfo.141.2023.08.28.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:02:31 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: loongson32: Remove unused dma.h and nand.h
Date:   Mon, 28 Aug 2023 21:02:23 +0800
Message-Id: <20230828130223.89898-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
unused platform devices"), no one is using dma.h and nand.h.
Therefore, remove these unused header files.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/dma.h  | 21 ----------------
 arch/mips/include/asm/mach-loongson32/nand.h | 26 --------------------
 2 files changed, 47 deletions(-)
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

base-commit: be87eab1320e25c7d43cec7ee59bc607050abe85
-- 
2.39.2

