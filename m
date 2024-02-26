Return-Path: <linux-kernel+bounces-80670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CFC866B09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD4E288ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E5154BFD;
	Mon, 26 Feb 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDETIlbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174941EEE7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932685; cv=none; b=ncJmFHCbvZKBjpvRqOZ9e7GKU/CxZqShLQXFZJPeUrI/rqaMxWMaOyQ0nIrJ9IBdl5/iAL1OwcCxmKsYwNE2Xh0DyjGWxMRPoj5SVm43lzKBCxBH2PJf3GD7JAa+Ijgo8gKxhxx8ceRCHN15h0oPqxqnQmr9qHn24gv1Jg9odYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932685; c=relaxed/simple;
	bh=uZkJGnv5IDuO8+ZvDjL7x5PwIEPpvDDhlojaAu1G7Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sECOsRgK1yG3J17lFoEiK8ymHNCs8LSlxVBNuIvm2zFf7HDRCClC/BARPbZrTlHNYyXPeBq5CgHcW6tBE68yyiMaUehUvj/v5OkoX8N9XjTWvXgKcGA5UYKRYGVG8xo3NTXA8hUE5uh5MZV4cS0hlYRyE77h368A7rkb70WB4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDETIlbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09D12C41679;
	Mon, 26 Feb 2024 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932684;
	bh=uZkJGnv5IDuO8+ZvDjL7x5PwIEPpvDDhlojaAu1G7Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GDETIlbxnBG5mil+Uivj9xnMmvWSFqucmd4YFTSKVm8AVed+5t2Na9DG/5iJpwN4q
	 1uBxGd2VVBwo+jyDt35JYVB4CuILAS3g0LnjOt/mA7eTbRbuzwbpDroziBX00LloW/
	 g//WVzLDZQlqCBHON3rNpBPCmfXigiDPNuxfzupxFV1ZuWmXnJw/P5++RqDRFUHHoW
	 H1DD2fbWC4q8oVxzOIUdcyrEDLTSZVzB+iZAme/s1rZZcji+nxwS1Gj2mzaiIVzG/L
	 QuTgQ4qloOfY4R1FDNrAtVEGq/k9Tey6GSKTSn86eFnwxFLJnCv6MqtWPu5fOg6awI
	 RgbH6RVPw1kiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED07AC5478C;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:32 +0300
Subject: [PATCH v8 36/38] ARM: ep93xx: soc: drop defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-36-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Thierry Reding <thierry.reding@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=3028;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=r88ZSksaS28Z3JM0eLBOGcjCM+5d/zZG8n9oNgV84Dc=; =?utf-8?q?b=3DMf/5CVsY6TLn?=
 =?utf-8?q?OaA/0VIZp+6p/GbA24vU7ElRPGNHpsue87ApSTEkweFzph4+esGUXusskTfEoSEL?=
 4dwjFC1JBYKhfYOM7DbvX4beYwvAG0yIPoaCzWT444EWmQ9GVWZl
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

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


