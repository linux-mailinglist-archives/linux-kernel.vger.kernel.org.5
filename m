Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3820A7D603B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjJYDFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJYDFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:05:07 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E6410E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:05:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce2bcb131fso3416415a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698203104; x=1698807904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=J2J+msM/oWEHBTBfFGIdBATMYCWzZZTEcIR2Uu0nKJs=;
        b=dSvb1hpGdzQR4yYnZ48ewGBEGszJ7DSlM00/oqtk5oto934VgSx+Ct3JzXdB3omWbz
         P2TdYQ4NU+T7hUhJ59w/YclEf7gVYII9+c81KcjQ/hzCm5PPq/L0//OgDaXL/wh1zfkp
         2DdCiRa1uCuGmV3rymMXX3Xke/5YjzdBqOU/t8QeOCUpsF5K5k/ofrGXMZp69XDJ9Hdb
         85g8iuFeKUx52uNYzEXhriZAJ6lrVA8ExiSCGm2EVhUQlTbJkvoMdcI7KTEJV+5qVZj5
         YNP8wTFImjPOFTb62jriHomGDf9J3Ge4Al0aHicHiSisURvn3v8hB/Kuy4hqZRDn+dYQ
         /vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698203104; x=1698807904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2J+msM/oWEHBTBfFGIdBATMYCWzZZTEcIR2Uu0nKJs=;
        b=jcekL4hm+I/qbiXdumneKVFTQjBCx1F/4JFp8QjCu4KIcMtcOU3WMxtSRokWzTVxfU
         misUKmBDDqzuOM/2pNOoKm0stKW0SV3uAPaEVO9Gb3ROM7QTQodS0kKvaneaBWZwXhoi
         n210Sdf9+hMRQShgYHbh0dEYphJvZkvm1DBDkosCINn3baII2lTxsaHlDdxLcmIF9vma
         iRlW/c1eFcTEo3zpPY6ls/ViCgiCWBZ2404cXLLtG1b+pPFKt63py24owIgZ6MmDY7d7
         RaO/03Pr8U7crJiSC8D2RgYeYcPf/Lf7t5hebsTHuS5m2hRwmj6z/XLIByKgsvCmIiQz
         3cIg==
X-Gm-Message-State: AOJu0YxEKSdPUz7w4nAkZGV7v8ghQgqjYhGo/dyxveT55Ky6dMWm9rcj
        NJ9udqW3jHu1tuOGW841Qz/ltrWc7Hlz0kKG
X-Google-Smtp-Source: AGHT+IHtgb1lylNWn3sPpR1wPW5dnAue/+pEsxDnLngtYcX/hbZzJx567JhNOh7AJ1stkbuTgXtBlA==
X-Received: by 2002:a9d:7ac6:0:b0:6c0:a98f:56e0 with SMTP id m6-20020a9d7ac6000000b006c0a98f56e0mr14244442otn.38.1698203103691;
        Tue, 24 Oct 2023 20:05:03 -0700 (PDT)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id m26-20020a6562da000000b0059ce3d1def5sm6755753pgv.45.2023.10.24.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 20:05:03 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mtd: spi-nor: Improve reporting for software reset failures
Date:   Wed, 25 Oct 2023 11:05:01 +0800
Message-Id: <20231025030501.490355-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

When the software reset command isn't supported, we now report it
as an informational message(dev_info) instead of a warning(dev_warn).
This adjustment helps avoid unnecessary alarm and confusion regarding
software reset capabilities.

v2. only lower the priority for the not supported failure
v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/mtd/spi-nor/core.c | 5 ++++-
 drivers/spi/spi-mem.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..42e52af76289 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		if (ret == -EOPNOTSUPP)
+			dev_info(nor->dev, "Software reset enable command doesn't support: %d\n", ret);
+		else
+			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index edd7430d4c05..93b77ac0b798 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return ret;
 
 	if (!spi_mem_internal_supports_op(mem, op))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->spi, 0)) {
 		ret = spi_mem_access_start(mem);
-- 
2.34.1

