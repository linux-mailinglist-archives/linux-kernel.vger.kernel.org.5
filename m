Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B97EC449
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbjKOOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjKOOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:01:17 -0500
X-Greylist: delayed 76 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 06:01:13 PST
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2B123;
        Wed, 15 Nov 2023 06:01:13 -0800 (PST)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Wed, 15 Nov 2023 15:01:04 +0100
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
        ; Wed, 15 Nov 2023 15:01:04 +0100
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 15 Nov 2023 15:01:04 +0100
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 15 Nov 2023 15:01:04 +0100
Date:   Wed, 15 Nov 2023 15:01:04 +0100
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     <tudor.ambarus@microchip.com>
CC:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 3/3 stable-6.1] spi: spi-atmel: enable dma on
 AT91SAM9G45
Message-ID: <2863edc4-5daa-d8d6-5e8d-b9dc244bcb82@pcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 15.11.2023 13:02:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Pfaff <tpfaff@pcs.com>

AT91SAM9G45 spi has version 0x210, but dma is working on it.

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index eaf4f9ff2504..1e4722bdcb2d 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1395,8 +1395,8 @@ static void atmel_get_caps(struct atmel_spi *as)
 
 	as->caps.is_spi2 = version > 0x121;
 	as->caps.has_wdrbt = version >= 0x210;
-	as->caps.has_dma_support = version >= 0x212;
-	as->caps.has_pdc_support = version < 0x212;
+	as->caps.has_dma_support = version >= 0x210;
+	as->caps.has_pdc_support = version < 0x210;
 }
 
 static void atmel_spi_init(struct atmel_spi *as)


