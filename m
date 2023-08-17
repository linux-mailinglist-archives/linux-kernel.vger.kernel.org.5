Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8D77F6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350944AbjHQMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350955AbjHQMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:47:11 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B122D5F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:47:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-790a590237aso317964539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692276430; x=1692881230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk/x1WgPO/AlMa1TTiVO596GRM+JBKXZoRvmU4Nx+SQ=;
        b=q5ZI/jzS1YDFzzHjNHY4qdZ5/p5A7NA0HOFUM7zornF4rCxZ/fyV5MfQrozc/v/odd
         /jKLtQ88oeyUSXMn8Smx6x/2+s1NISGVDv76WNsH7Y16oo8o8wiuT5Y+qGBiajxpAqYA
         rNKxrr9yN1LaqbynUkFNFpPeWsLwVc9U3KWZDMJpAskF+IYL065KS2xC/UxT2aq+lkKJ
         nEOPhfFAp69Z+gR2/haCvaEY057U6q2LKUd2Q179UyzyjJkDWKImyA6zZ62C3D8cbxX0
         21zXqlZ02MxY4KOrmXP6O9nPfvhhj/nQX+HrcOQXFTncZpDBEwD9wa0ZLmZ9m4QGIfpN
         wpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276430; x=1692881230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jk/x1WgPO/AlMa1TTiVO596GRM+JBKXZoRvmU4Nx+SQ=;
        b=Fn8RF+a+wTguiKjp4OEtTTqjw7jQQxBm0Q0yXaF+wfaEMu5HbxvP5u4nho1WLOHJ0/
         MYFgaToNRfFL3Z1aFFZsoDpuOYT26TcdfGCDdzAXfEF3WAES+wQeIRJO/jX7ZdhqiIPW
         ViVjkQQSbdUO17U5jpZivA//vXubvwUOuWcJmfxEi6PrWbig8r1T4eVKzoXdniycvrfc
         HebeGV2I63wlXZUjCJ8wdEI8pMwJFGLIwnMZcxjHv/4Vd9jFz0ufZ3pmBnPwjpOJEInQ
         8X1Jlwq9/vxlEnrfx9WKMSMBuu24o+pQqVZu+YjJdUNJP1xyIZiMCSVKahe55gR09TcP
         RaVQ==
X-Gm-Message-State: AOJu0YwglFElFWcPWLgitjG6hsop9MLE7ZHwVVyMKXabUQq0+F+4CK47
        Waq93KMhDp9tSiGUAtmoD80=
X-Google-Smtp-Source: AGHT+IFyMdjNuba+cK+Tk0k2tfQFtaprGC7v/D47Z+GX9417vdcqElKKValjw/t+I7StSEJHzhmsCg==
X-Received: by 2002:a5e:c206:0:b0:787:953:514b with SMTP id v6-20020a5ec206000000b007870953514bmr6339586iop.3.1692276429771;
        Thu, 17 Aug 2023 05:47:09 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
        by smtp.gmail.com with ESMTPSA id s18-20020a02cc92000000b0043167542399sm150505jap.99.2023.08.17.05.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:47:09 -0700 (PDT)
From:   SSunk <ssunkkan@gmail.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        SSunk <ssunkkan@gmail.com>
Subject: [PATCH] Add support for more XMC series
Date:   Thu, 17 Aug 2023 20:46:55 +0800
Message-Id: <20230817124655.13023-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
and set the parse_sfdp flag.

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

