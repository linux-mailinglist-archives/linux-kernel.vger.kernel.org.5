Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4E80E611
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346295AbjLLIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346108AbjLLIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:22:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68ED5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E31EC32798;
        Tue, 12 Dec 2023 08:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369326;
        bh=rr6q7hqGehAxChMRJyQyeh9gPseemY3qbXcOyMjzHAw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Z3J3YQ6yBcXfyvcQCnyR2frVkSgVPRWGv6Jffk1ht9BEORhRJPepNVSYrou7D49D+
         k3UzLqoVYAgiuGbWmzolQxSgykR9x5vJ1Op1C8RamscGtVdU6YJf663KtYybg8hRJm
         RB4GQF14IS7I9fQJN6XQaQJIuJLM8uQuDWEk1LDyegbbUxUMY4AEDmULpHasTmFtmZ
         l/6NAKcU+4M3vJJ2/5EvbG97RiDjdV3qjQydnNpeyJxz90bBV1vEavY5SG8WDPWCC0
         EJOpM794pfZR2VVg1LAJgAOT9W9V1ZDV9N0uye70NEqaF61H+OAfGTrfeFJ/oFuytb
         /l6bMa5rDP2xA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3FAC38147;
        Tue, 12 Dec 2023 08:22:06 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:57 +0300
Subject: [PATCH v6 40/40] dma: cirrus: remove platform code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-40-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Vinod Koul <vkoul@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=6035;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=S2OkZzw9mrYPHmucNS7NVCBHwOKa4SSXUVmcISI3Wc0=; =?utf-8?q?b=3DnGnDR8pqdtK9?=
 =?utf-8?q?7jer2GFKwfrrapeiLdLnY5wHikTvOfvHanAeAlbbQN2M77WN/daSOs2A8PMJQIRe?=
 xWMoJuBuCYLjFOso2KQbNYeXo5ymCLYMkqu5PGKQnGtYlvhszBJl
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Remove DMA platform header, from now on we use device tree for dma
clients.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/dma/ep93xx_dma.c                 |  48 ++++++++++++++-
 include/linux/platform_data/dma-ep93xx.h | 100 -------------------------------
 2 files changed, 46 insertions(+), 102 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index b7dd8361f490..d11cd11f32bf 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -25,8 +26,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
-
 #include "dmaengine.h"
 
 /* M2P registers */
@@ -106,6 +105,26 @@
 #define DMA_MAX_CHAN_BYTES		0xffff
 #define DMA_MAX_CHAN_DESCRIPTORS	32
 
+/*
+ * M2P channels.
+ *
+ * Note that these values are also directly used for setting the PPALLOC
+ * register.
+ */
+#define EP93XX_DMA_I2S1			0
+#define EP93XX_DMA_I2S2			1
+#define EP93XX_DMA_AAC1			2
+#define EP93XX_DMA_AAC2			3
+#define EP93XX_DMA_AAC3			4
+#define EP93XX_DMA_I2S3			5
+#define EP93XX_DMA_UART1		6
+#define EP93XX_DMA_UART2		7
+#define EP93XX_DMA_UART3		8
+#define EP93XX_DMA_IRDA			9
+/* M2M channels */
+#define EP93XX_DMA_SSP			10
+#define EP93XX_DMA_IDE			11
+
 enum ep93xx_dma_type {
 	M2P_DMA,
 	M2M_DMA,
@@ -242,6 +261,31 @@ static struct ep93xx_dma_chan *to_ep93xx_dma_chan(struct dma_chan *chan)
 	return container_of(chan, struct ep93xx_dma_chan, chan);
 }
 
+static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
+{
+	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
+		return true;
+
+	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
+}
+
+/*
+ * ep93xx_dma_chan_direction - returns direction the channel can be used
+ *
+ * This function can be used in filter functions to find out whether the
+ * channel supports given DMA direction. Only M2P channels have such
+ * limitation, for M2M channels the direction is configurable.
+ */
+static inline enum dma_transfer_direction
+ep93xx_dma_chan_direction(struct dma_chan *chan)
+{
+	if (!ep93xx_dma_chan_is_m2p(chan))
+		return DMA_TRANS_NONE;
+
+	/* even channels are for TX, odd for RX */
+	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+}
+
 /**
  * ep93xx_dma_set_active - set new active descriptor chain
  * @edmac: channel
diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
deleted file mode 100644
index 67d65f1cb564..000000000000
--- a/include/linux/platform_data/dma-ep93xx.h
+++ /dev/null
@@ -1,100 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_ARCH_DMA_H
-#define __ASM_ARCH_DMA_H
-
-#include <linux/device.h>
-#include <linux/property.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
-
-/*
- * M2P channels.
- *
- * Note that these values are also directly used for setting the PPALLOC
- * register.
- */
-#define EP93XX_DMA_I2S1		0
-#define EP93XX_DMA_I2S2		1
-#define EP93XX_DMA_AAC1		2
-#define EP93XX_DMA_AAC2		3
-#define EP93XX_DMA_AAC3		4
-#define EP93XX_DMA_I2S3		5
-#define EP93XX_DMA_UART1	6
-#define EP93XX_DMA_UART2	7
-#define EP93XX_DMA_UART3	8
-#define EP93XX_DMA_IRDA		9
-/* M2M channels */
-#define EP93XX_DMA_SSP		10
-#define EP93XX_DMA_IDE		11
-
-/**
- * struct ep93xx_dma_data - configuration data for the EP93xx dmaengine
- * @port: peripheral which is requesting the channel
- * @direction: TX/RX channel
- * @name: optional name for the channel, this is displayed in /proc/interrupts
- *
- * This information is passed as private channel parameter in a filter
- * function. Note that this is only needed for slave/cyclic channels.  For
- * memcpy channels %NULL data should be passed.
- */
-struct ep93xx_dma_data {
-	int				port;
-	enum dma_transfer_direction	direction;
-	const char			*name;
-};
-
-/**
- * struct ep93xx_dma_chan_data - platform specific data for a DMA channel
- * @name: name of the channel, used for getting the right clock for the channel
- * @base: mapped registers
- * @irq: interrupt number used by this channel
- */
-struct ep93xx_dma_chan_data {
-	const char			*name;
-	void __iomem			*base;
-	int				irq;
-};
-
-/**
- * struct ep93xx_dma_platform_data - platform data for the dmaengine driver
- * @channels: array of channels which are passed to the driver
- * @num_channels: number of channels in the array
- *
- * This structure is passed to the DMA engine driver via platform data. For
- * M2P channels, contract is that even channels are for TX and odd for RX.
- * There is no requirement for the M2M channels.
- */
-struct ep93xx_dma_platform_data {
-	struct ep93xx_dma_chan_data	*channels;
-	size_t				num_channels;
-};
-
-static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
-{
-	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
-		return true;
-
-	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
-}
-
-/**
- * ep93xx_dma_chan_direction - returns direction the channel can be used
- * @chan: channel
- *
- * This function can be used in filter functions to find out whether the
- * channel supports given DMA direction. Only M2P channels have such
- * limitation, for M2M channels the direction is configurable.
- */
-static inline enum dma_transfer_direction
-ep93xx_dma_chan_direction(struct dma_chan *chan)
-{
-	if (!ep93xx_dma_chan_is_m2p(chan))
-		return DMA_TRANS_NONE;
-
-	/* even channels are for TX, odd for RX */
-	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-}
-
-#endif /* __ASM_ARCH_DMA_H */

-- 
2.41.0

