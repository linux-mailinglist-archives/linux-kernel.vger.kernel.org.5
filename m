Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6925F7A185F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjIOINx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjIOINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:13:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8A2D43
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:12:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87574C433BB;
        Fri, 15 Sep 2023 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765530;
        bh=Ryyc4O+UjDaoiSIUnChIWQE2FZXqVLPtozhb4qkonJw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=jxy5O2ew1X7MFoRmb4Y0ShkTg4uLiRA35qL0qZzChOWCzLMvU+1QM7BES7jStHwJt
         A/U1m5FMtJD94QFp6vg3Pu1SXWB9HfklC7R/oLa3EsSZMkBGk8QOv/fcNoASNfkjVc
         0u0M7kNrtZc98ZIQnRTF8Vz8+tfxXjlEwI64YeLGW7eChhqQ+6hL7DOw/CGn4fw5iG
         Lcf7YAIpLlpnvkfrBM6O2bLqD2hwy2zNaqaJa/kup5dd77lI5Sohg2Ov7zhESEEEjQ
         5a++yRQoqIts72J7WySywD3CGqLBafnmlGEs7DepUPZasFCNnGoMlApY17M/dIqQdu
         /9zy9XZaM+o6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 74409EE643D;
        Fri, 15 Sep 2023 08:12:10 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:11:22 +0300
Subject: [PATCH v4 40/42] ARM: ep93xx: soc: drop defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-40-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=3354;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=eGe0oIR5ltAwpXa8VN2eQPSfHKPm73WhhZb9Tri1d9M=; =?utf-8?q?b=3Dq3fpInwQRNDP?=
 =?utf-8?q?M3JMYCI3fdBAYC7eBbOdLsB4icethmmRkHY8NTqJBEYpmOFA72fUnW7pbl+hLi5O?=
 Rb7SkqdCA7oAvSXiDvCVtyajD1e5nzxCjNXtTwap5UsccFspT7CA
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Remove unnecessary defines, as we dropped board files.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 include/linux/platform_data/eth-ep93xx.h    | 10 ---------
 include/linux/platform_data/keypad-ep93xx.h | 32 -----------------------------
 include/linux/soc/cirrus/ep93xx.h           | 12 -----------
 3 files changed, 54 deletions(-)

diff --git a/include/linux/platform_data/eth-ep93xx.h b/include/linux/platform_data/eth-ep93xx.h
deleted file mode 100644
index 8eef637a804d..000000000000
--- a/include/linux/platform_data/eth-ep93xx.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PLATFORM_DATA_ETH_EP93XX
-#define _LINUX_PLATFORM_DATA_ETH_EP93XX
-
-struct ep93xx_eth_data {
-	unsigned char	dev_addr[6];
-	unsigned char	phy_id;
-};
-
-#endif
diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
deleted file mode 100644
index 3054fced8509..000000000000
--- a/include/linux/platform_data/keypad-ep93xx.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __KEYPAD_EP93XX_H
-#define __KEYPAD_EP93XX_H
-
-struct matrix_keymap_data;
-
-/* flags for the ep93xx_keypad driver */
-#define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset */
-#define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
-#define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
-#define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
-#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */
-
-/**
- * struct ep93xx_keypad_platform_data - platform specific device structure
- * @keymap_data:	pointer to &matrix_keymap_data
- * @debounce:		debounce start count; terminal count is 0xff
- * @prescale:		row/column counter pre-scaler load value
- * @flags:		see above
- */
-struct ep93xx_keypad_platform_data {
-	struct matrix_keymap_data *keymap_data;
-	unsigned int	debounce;
-	unsigned int	prescale;
-	unsigned int	flags;
-	unsigned int	clk_rate;
-};
-
-#define EP93XX_MATRIX_ROWS		(8)
-#define EP93XX_MATRIX_COLS		(8)
-
-#endif	/* __KEYPAD_EP93XX_H */
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 3212a145ae0f..c5ac75ee2d2b 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -2,7 +2,6 @@
 #ifndef _SOC_EP93XX_H
 #define _SOC_EP93XX_H
 
-struct platform_device;
 struct regmap;
 
 #define EP93XX_CHIP_REV_D0	3
@@ -11,16 +10,6 @@ struct regmap;
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
-#if defined(CONFIG_EP93XX_SOC_COMMON)
-int ep93xx_i2s_acquire(void);
-void ep93xx_i2s_release(void);
-unsigned int ep93xx_chip_revision(void);
-
-#else
-static inline int ep93xx_i2s_acquire(void) { return 0; }
-static inline void ep93xx_i2s_release(void) {}
-static inline unsigned int ep93xx_chip_revision(void) { return 0; }
-
 #if defined(CONFIG_EP93XX_SOC)
 void ep93xx_regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
 void ep93xx_regmap_update_bits(struct regmap *map, unsigned int reg,
@@ -32,7 +21,6 @@ static inline void ep93xx_regmap_update_bits(struct regmap *map, unsigned int re
 					     unsigned int mask, unsigned int val)
 { }
 
-#endif
 #endif
 
 #endif

-- 
2.39.2

