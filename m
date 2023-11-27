Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0717FA773
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjK0REG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjK0RDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:03:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581EF7ED0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:59:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b3e2f8ec5so18853305e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701104352; x=1701709152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ35+8dHLOqajNjcQcF3HUrNBv1ZIoocmdTe8D0V50U=;
        b=kDQrP4dADfI4gcJG0CrpIbswmEr9UbuIlOro28L3X0UlnsEnOCqCiA5CYta6TyAB3L
         XnyI1/jNyTRrD/Nfu8F2yhRCWfvfSUI7qzaR0YCYBdWr5WsggTWXpysFhLFfuQUW6BJd
         VnFx7ZNrIiWITyP6EYo17HJ3Gajt1qkJIRddPE2EXCI9Ufwbfi7duJ0kTm1nWzO1gh9w
         crWSgxcNS95dx6YQbCqz16mSLdxjI1yYujc5yiKgrjxffEoSB/BOZwq73lVPHQP9bOTm
         IHShKitedDJ3xyP9TjQW43AClTSiIXkDgBaQd5968sBF26nNUzTicN1yY+kLC6ctxGq8
         aSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104352; x=1701709152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZ35+8dHLOqajNjcQcF3HUrNBv1ZIoocmdTe8D0V50U=;
        b=F+zA6RjoFVOrcQ0bPaPNRGQh3aL+pQEG7YykeP/RZXpAUr97LFJX1rR/NDl0tyIwgO
         zCrjbtnUTEqdOFUfp++ps3LZA+lXFc0asLQ6lw1Qv/VA1MMyG1rjh23KGn3ufkwWf3SH
         PoYnK/os8ja6x74vo60+SpwUy22yZQJLK5Eu1OtJ2ct15yD/Q8mxhqJRn2cFE93Hf+Fw
         6D14YMqWnIT7pyMSSShwLmLvNmtL8GWztEXR87xZ4GtLCLMEEdJ+MkTLM8VxDvTk2ok7
         5slhrhoYjmXQWlLfs33s/ttxb3Jr5ZK8w7KL2Gukkd5J10d+CWrI24ShBmFL51DqOcO8
         xWog==
X-Gm-Message-State: AOJu0YyZ9y8hfZoDYK2HpfZ7RT8Zno0fSzTyOyqtAesCRf7X38jeztjK
        J2igDEotqlwRMHiOc/JYbZzmbQ==
X-Google-Smtp-Source: AGHT+IGWC72QjNtBr3UIdhR6rkbzgM5TklxBcQjl+NxEKQe4jMzhVI+BS9Zs7YJNA+tiYEYe0JaYoQ==
X-Received: by 2002:a05:600c:296:b0:40b:47dc:9b9d with SMTP id 22-20020a05600c029600b0040b47dc9b9dmr1733483wmk.40.1701104351691;
        Mon, 27 Nov 2023 08:59:11 -0800 (PST)
Received: from ta2.c.googlers.com.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b0040b34720206sm14477219wmq.12.2023.11.27.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:59:11 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, miquel.raynal@bootlin.com,
        jaimeliao.tw@gmail.com, jaimeliao@mxic.com.tw, pratyush@kernel.org
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: stop printing superfluous debug info
Date:   Mon, 27 Nov 2023 16:59:08 +0000
Message-ID: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtd data can be obtain with the mtd ioctls and the SPI NOR
flash name can be determined interrogating the sysfs entries.
Stop polluting the kernel log.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 25a64c65717d..6de76fd009d1 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3517,25 +3517,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	/* No mtd_info fields should be used up to this point. */
 	spi_nor_set_mtd_info(nor);
 
-	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
-			(long long)mtd->size >> 10);
-
-	dev_dbg(dev,
-		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
-		".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
-		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
-		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
-
-	if (mtd->numeraseregions)
-		for (i = 0; i < mtd->numeraseregions; i++)
-			dev_dbg(dev,
-				"mtd.eraseregions[%d] = { .offset = 0x%llx, "
-				".erasesize = 0x%.8x (%uKiB), "
-				".numblocks = %d }\n",
-				i, (long long)mtd->eraseregions[i].offset,
-				mtd->eraseregions[i].erasesize,
-				mtd->eraseregions[i].erasesize / 1024,
-				mtd->eraseregions[i].numblocks);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
-- 
2.43.0.rc1.413.gea7ed67945-goog

