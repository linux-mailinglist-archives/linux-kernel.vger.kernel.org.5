Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6227CF04C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjJSGp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjJSGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:45:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0C10F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:45:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-564b6276941so5744240a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697697950; x=1698302750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VnD+4+o/AktznkdSPALDpojy3+u5FZvAU0rtTI4+TYE=;
        b=FZBwIrRiMLZ6vbqL2h0xmarz1F1op4HVyQwQ6SYX5VFwklrCyiM+YuEMpgf8wFjtfb
         Wo//DH0LiLw15xokIVf1egwAwNRwe7SzZVY/sSZMuAkvxxW3z3cGneVvmn2SP3O8Xpb9
         1p+aFN6EKw7Y7MWMzKQHkaFfL8VOnzyEHjjZ1R6dJ/unCNrQSRPXPjrWz6BdmpcQXYK/
         uU4lcy6Dznv+QAnrIA8HMFTfsGF6daMsSSxRgk6helsm6WEpshKofPaQgUIuZYtV5v62
         FVL9bU/j5LfcLyu4TtaUV/Q01k9DzeYuDdaBmDhl/nTAttY3z4Zae/MN8Rj4F33sq44b
         75Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697950; x=1698302750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnD+4+o/AktznkdSPALDpojy3+u5FZvAU0rtTI4+TYE=;
        b=DMYDL95lUnDY0yskupDhkNw6LZ3xsVez5okDT3GGuD1lrew6e77uglsogZZA8XQXhg
         tJP0Hb9iChh9ISTpZCpdvLluoYJRAV++8y9sj60L6DPwsXbCAls98ko19EixQta7rG52
         Z/E2/dH/yC961SbD0C+ec8aKY+KW5GJPQuFTNq90C229qzSGXkehA1ljGc8ECr282oFT
         8nlvnxpfPflDlfkrhrQeKy7aISE2K8k4w44lS5DSUciXzXTlNQZhDcT54mIDAu7Z02WL
         eD0wjdCO/qLy5JWcSrWZLF+JSUd35oOq+rHdYk/2woTq0tSfLk3CWUR75vTLWHFALSGe
         SY1g==
X-Gm-Message-State: AOJu0YyNDm1JETGUcvESygjtnya4ThAEGkp1wrsl8lSPQokrCwIFHdq4
        TsFpDzyj8Ktd4DCJ8B5TZ58=
X-Google-Smtp-Source: AGHT+IE1WPyhscv9usKnV6Tvcm7NkIcFn9ykGqFUpUm5bk7HtzJmvn92SJo6z7jtF5q3VfnCewsPhw==
X-Received: by 2002:a17:90a:94c2:b0:27d:2b81:5798 with SMTP id j2-20020a17090a94c200b0027d2b815798mr1179229pjw.48.1697697950140;
        Wed, 18 Oct 2023 23:45:50 -0700 (PDT)
Received: from localhost (211-75-139-217.hinet-ip.hinet.net. [211.75.139.217])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090ae50800b0026b46ad94c9sm879353pjy.24.2023.10.18.23.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:45:49 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: Lower the priority of the software reset failure message
Date:   Thu, 19 Oct 2023 14:45:47 +0800
Message-Id: <20231019064547.348446-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

Not all SPI drivers support soft reset enable and soft reset commands.
This failure is expected and not critical. Thus, we avoid reporting it
to regular users to prevent potential confusion regarding power-off issues.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/mtd/spi-nor/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..7bca8ffcd756 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3252,7 +3252,7 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		dev_info(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
@@ -3262,7 +3262,7 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		dev_info(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
-- 
2.34.1

