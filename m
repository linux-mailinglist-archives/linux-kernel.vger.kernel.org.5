Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0603C756131
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGQLGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:06:42 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45026E45
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:06:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-76c64da0e46so227925739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689592001; x=1692184001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haVFqWj7QwEPz8RYxJRQEPBOrTTJvQggCktBjSbVKB4=;
        b=O8LmcS3Jf0qq58gvBFtuZhHrnnwIouCgGhdhOQ9OPUT88XsfExfnHtp071pecSyIrm
         UPebMf8og6ctAdU6ZW3bU2Q6DeZS15Zk9u/vLwVZloptx+ejg0Nj9uNpjJBoWhGlYvzs
         AF2SsAy+oMIUE4ufinHCFoBw9Rqhm4eqUeHyoqIFpnIFrFmmAvMbZ6z/vFRHdGKJP7nI
         xeSnozo0yEQvD6u/q5t4MiqUgz270mi8tXetzTpDBL9Q2B3VxUliisfLFakiAHRGWzaq
         vDkabMKn26aOOgt0fr9cJzv/cheCfcD24A3jpkbs3D8+qW5qJzu1CxRekC6/CflxQNTF
         9kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689592001; x=1692184001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haVFqWj7QwEPz8RYxJRQEPBOrTTJvQggCktBjSbVKB4=;
        b=Ydht2k2Uaa634+EHgO9+W9BOBQV1tn+LmyRyWUjZ8vNFySESP0IE/WinqEX8R9K3Eg
         IV5wM3v9YgXMjHTfEDX/7XVEvJNsL12Ta3WCxaswjRfHBRi1SWBYMb+5y/drJXRu8mXr
         DzGL1M0cvIjIojW7jPIF95arkQppraDu8LffcTBPQVwMLn5UWf0wjING0C3gq9w2eg6L
         o2MxvdrmyO3OIPRNMdu0sPJv8Zh07kysFbgz+o55VkBmW8TxhUR1A6QhfAgt2JNCHznm
         h8eV/ZJ3xEjpy/19jSAav5yRiZux6qxJvLYfV+nGOzH+jN4Y7o0HeatjaW5MuuhiWU65
         O73w==
X-Gm-Message-State: ABy/qLZ9GlvNKK4QTEsxiUDHLMomGTaR3ZxM8Gyw7xOG8kd4Xbkbb2ZC
        skpnzBxRCPxh1y2B7n5t0uU=
X-Google-Smtp-Source: APBJJlF2KECXm2ypo4ZfIADjLDCl2fo6qU4eEBprTsFoXDtohC0Im35kZyIMTwARME8rgcdfY3q3Cg==
X-Received: by 2002:a05:6602:2563:b0:783:62d0:88c with SMTP id dj3-20020a056602256300b0078362d0088cmr11201087iob.19.1689592001378;
        Mon, 17 Jul 2023 04:06:41 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
        by smtp.gmail.com with ESMTPSA id o8-20020a02cc28000000b0042acf934cbasm4212826jap.72.2023.07.17.04.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:06:41 -0700 (PDT)
From:   SSunk <ssunkkan@gmail.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        SSunk <ssunkkan@gmail.com>
Subject: [PATCH] Add support for XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
Date:   Mon, 17 Jul 2023 19:06:25 +0800
Message-Id: <20230717110625.8844-1-ssunkkan@gmail.com>
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

Add more XMC chip support

Signed-off-by: SSunk <ssunkkan@gmail.com>
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

