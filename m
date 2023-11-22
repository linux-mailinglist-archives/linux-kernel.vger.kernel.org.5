Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34E87F4119
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjKVJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbjKVJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7332D52
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E50C433AB;
        Wed, 22 Nov 2023 09:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643676;
        bh=9ute/1bGOtjO25p99pXUCKMJ0N82xWZ9Win5PXJgY0Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=e2+ypS3N13fpBne/92+1EUrxPDNQUzUy51HbHOcwL3Z+RLpgO3ihZAkMwRKV7TqAJ
         O2nolodHDydoKcR+TGxuK61FVa9X+YufcXaBvqQT7JNVSmtix045W1TSCqowBlzQs7
         9YnOwwqeGeC+lKvow66YitrI1MnAl8r4vFXtjUOVMl5P/y9oA9b11Ij/xfNo6fB4H3
         VgBs6Emt8qHf3Fh7CsfJQGCbCLS1S+ma2xeAEbUuOHELH3mnNVQLeyk+iXqamzsssH
         tz/xYzYxHkpFg4dneCHUI0HOm2TQ6nXHg4PtNTN1zL6b5Zt+A7aFZuZpgnOwEQJVIE
         17+tldUZVmcVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 36DFFC61DA7;
        Wed, 22 Nov 2023 09:01:16 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 12:00:15 +0300
Subject: [PATCH v5 37/39] ARM: ep93xx: soc: drop defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-37-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=3033;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=6XiaHQokkrEF1VJqw8MFtxq6mielfCuEj4N2Lba9alA=; =?utf-8?q?b=3DJ1GLKimaPeEi?=
 =?utf-8?q?GqineB/kEcsXLGqrDEGQfK9WYsi/ABH9lJSSG5LuibGO48toXLz3noTA5kXbraLd?=
 40KE33F1DhgyxshmsBOgQJH/TN5Tc1r6GjVCThSkeegdEuYuVm0v
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 include/linux/soc/cirrus/ep93xx.h           | 13 ------------
 3 files changed, 55 deletions(-)

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
index da8bdfc36526..a9b8d2709797 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -2,7 +2,6 @@
 #ifndef _SOC_EP93XX_H
 #define _SOC_EP93XX_H
 
-struct platform_device;
 struct regmap;
 
 enum ep93xx_soc_model {
@@ -36,16 +35,4 @@ struct ep93xx_regmap_adev {
 #define to_ep93xx_regmap_adev(_adev) \
 	container_of((_adev), struct ep93xx_regmap_adev, adev)
 
-#ifdef CONFIG_ARCH_EP93XX
-int ep93xx_i2s_acquire(void);
-void ep93xx_i2s_release(void);
-unsigned int ep93xx_chip_revision(void);
-
-#else
-static inline int ep93xx_i2s_acquire(void) { return 0; }
-static inline void ep93xx_i2s_release(void) {}
-static inline unsigned int ep93xx_chip_revision(void) { return 0; }
-
-#endif
-
 #endif

-- 
2.41.0

