Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646AC758023
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjGROwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjGROwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:52:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DD71719
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:51:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso243334739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689691919; x=1692283919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GIqnnpdKb7I9nNR85AQsWNWcw2qSeUJtV+n6+XhZgY=;
        b=FgiACD5bcvZA+6cd5ApfIEjwVfwqozr0Q2kG/sudwiMboo9Obq3PgIQ5kQm9EmAFWv
         qNZYg+shgkYPyz7ogVTMOLKIi9OwRcFvlqNCluUuvaQUTLoB7R1GX8CUPbDywt/qKGDq
         Y0DA98mNxKrMsoaiGj158YRgEWUB0wCQB8fIY0PSEUJZA5n5lWJJ0DN0GdYqwXjCrgty
         D14g03A/8/lx5ediTE0yCfK1XXPMrqBD876GUt2CowZBA2HpzU7J3J5vz1jY3QQHxpss
         GslAAeMeXYQ4JeCQNilrLYkUte373Qd7z5CkF89IAGNM+Ey/etyQl+JAaYXf1qGPZw1U
         Pe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691919; x=1692283919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GIqnnpdKb7I9nNR85AQsWNWcw2qSeUJtV+n6+XhZgY=;
        b=ULx9BXxZ+J0j8mRE1KUpt2o7KT/LEfaOQZTyqhd0sr5dXeoATeaktMWnXaT3yR5Yl1
         2A9oo3Yexd+jc+vHfeNaV/CYukf+2nANscc5QsQH5+1lcxXojLjkYICf2MMFqOD4uAcj
         U0FkLgisJmaNFEK2Biirdmky44teGuiUFDvVWsLfERUhytfMl8e+iLbwxyTottk34ce0
         jdjUsozFDUmU0M25BXf+1VFVTo5JG19LE/jTTBvt2MiZzr2mKT6Yd++STs1hkt0z8QKd
         A0Zv8pIXVu82PTmEONZOBpj53Sqh6NDls0Q99xsFhBilYq7DKnKeUdt6mHP5ALgRx9bF
         IBdw==
X-Gm-Message-State: ABy/qLZIafAUXMl/qVeAYDMKYVt06FBbkRxfE22vsKTlIqkbPDROwoyD
        bOcBSO3kZEpreY1H48Z7bJU=
X-Google-Smtp-Source: APBJJlECvO3EIaJ3EtRZb/2Cg7Zv8tKC1ifI6mf15CtrBD+LtSh97R9MErvVDrgsCD10vQ/acmV+8Q==
X-Received: by 2002:a5e:c113:0:b0:786:26f0:3092 with SMTP id v19-20020a5ec113000000b0078626f03092mr2691239iol.3.1689691918977;
        Tue, 18 Jul 2023 07:51:58 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
        by smtp.gmail.com with ESMTPSA id o5-20020a02cc25000000b0042b4f9ddecasm589106jap.85.2023.07.18.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 07:51:58 -0700 (PDT)
From:   SSunk <ssunkkan@gmail.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        SSunk <ssunkkan@gmail.com>
Subject: [PATCH] Add support for XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
Date:   Tue, 18 Jul 2023 22:51:32 +0800
Message-Id: <20230718145132.3811-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C and do not use the generic spi nor driver.

Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
---
 drivers/mtd/spi-nor/xmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index 051411e86339..b2374187ec4f 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -16,6 +16,22 @@ static const struct flash_info xmc_nor_parts[] = {
 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
+	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+
 };
 
 const struct spi_nor_manufacturer spi_nor_xmc = {
-- 
2.34.1

