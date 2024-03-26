Return-Path: <linux-kernel+bounces-118673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37088BDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0846D1F61BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95412EBEF;
	Tue, 26 Mar 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDceUqkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671573537
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=JZkQDdME2r8vnY2pTjBZkl45FhcMaj3YDZFB/+z68Ly8npZWbWR8MCzzv5PRtWgVBTEMWUo4XZATsupE1f6sGFIv06gRiE3iUnNTnwMzC4ZUbtgSfz5nU2lOMPahbDqGZ3op/IeKSouKLyBxNl9KI5OlXT87SiauZlHUVvViVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=uZkJGnv5IDuO8+ZvDjL7x5PwIEPpvDDhlojaAu1G7Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGo0sl+TaZF4cjLmPXC7AwvXeVJFwq6JYJMT7mO7czDZ7P+n2jH4Xuwpx1erPl9fAOI5lxz+NKgK/hzg+vwNWwqMZrXQ7N/26Yk1R+yhNKUab+9V4DF18Rx7YlZYwfGFRuiYguOhlE0OKeewPyEH/gG0NVzyyu1v+XdEyemGlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDceUqkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1529C43330;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444843;
	bh=uZkJGnv5IDuO8+ZvDjL7x5PwIEPpvDDhlojaAu1G7Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MDceUqkm8alGxBRgirmqjOemBSqjzGmsHWUDpTQcTZKEhgWr9WpC3VwMmlYRPAbaB
	 7mWyFwAypMUJnCSWTN1cbXLAlFiqM4OJKgI+0hRrZAUF/4FQNSGAHTGCpS48Yf114I
	 1sTk7RZWw0SVu6WsbN6SlPluDSsz5CoTccGyEAfLdkB2XfmiVeA4Ra1BK6MBEFxukj
	 SLzCmERYkJAZRuXnGA5XeYY0uq3pVMkSTs6zUjdT+a/B2t4/l4aMZVRH7UW1AWNt+k
	 RLg3KycTMqizDQTAk3/55M8wdAwVP+BPM+mb98W7cQkt49cfyWa2+ajz9WtOwqZSpa
	 HfNjAxMR60/vA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCA8CD1283;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:19:03 +0300
Subject: [PATCH v9 36/38] ARM: ep93xx: soc: drop defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-36-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal <dlemoal@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=3028;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=r88ZSksaS28Z3JM0eLBOGcjCM+5d/zZG8n9oNgV84Dc=;
 b=z195lQq78/W/f4FhdTD1L9flrw9p2ftO4hdWpnxtJFYK/jd2efXlxolAZJRqbwd8mwcO0LFSVaER
 cEkLFxjnBcDpw9F+fZ1pdCI4yZbNe4wkEKYUHhd8pMiOGysDwcs4
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

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
index 142c33a2d7db..3e6cf2b25a97 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -2,7 +2,6 @@
 #ifndef _SOC_EP93XX_H
 #define _SOC_EP93XX_H
 
-struct platform_device;
 struct regmap;
 struct spinlock_t;
 
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



