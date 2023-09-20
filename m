Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B191D7A8D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjITULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjITULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:11:01 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B35D9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=3RWsqka5y+n3z712y56vrNdxFO4GCgD+sceIXglmDks=; b=L1M3tO
        O/jXi1Bgmm9KQxTN/qtvjmI4ZHHHhBtUjI/U6Ku7VWu+zwfxs2JkOWCLznys+tn9
        YWhiczea2nXTR+8xPhHSGjdNhvY/IE3clUHMxw2iSEsIyNlrlkFeyeasoFb9Cy/q
        RStJuKfZo9iwKM462tMTfwh9fGid5l7HzyxvX9L2pogCO0rwmple9s2Bexvyg1x+
        Xix1iqCpkhlDsxFoNjDWdARy1Av0hpKwxbAWGlkKv9ezuyl47y/0VwzjalSI+oWU
        rcMys7cOLsD9gxC1gsMXogtKY5HmEoawEQ4lh4aOgkAPQ57OsfRtNBo2ApAq8188
        xPYj96q7Y5sMmp2A==
Received: (qmail 720355 invoked from network); 20 Sep 2023 22:10:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2023 22:10:47 +0200
X-UD-Smtp-Session: l3s3148p1@jCWV+M8FuMkujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] MIPS: AR7: remove platform
Date:   Wed, 20 Sep 2023 22:10:32 +0200
Message-Id: <20230920201035.3445-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a discussion about removing VLYNQ support from the Kernel, it was
concluded that its only user, the AR7 platform can go [1]. Even OpenWRT
has removed support because these devices are "stuck with 3.18" [2].

[1] https://lore.kernel.org/r/3395161f-2543-46f0-83d9-b918800305e1@gmail.com
[2] https://openwrt.org/docs/techref/targets/ar7

Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/mips/Kbuild.platforms              |   1 -
 arch/mips/Kconfig                       |  22 -
 arch/mips/ar7/Makefile                  |  11 -
 arch/mips/ar7/Platform                  |   5 -
 arch/mips/ar7/clock.c                   | 439 --------------
 arch/mips/ar7/gpio.c                    | 332 -----------
 arch/mips/ar7/irq.c                     | 165 ------
 arch/mips/ar7/memory.c                  |  51 --
 arch/mips/ar7/platform.c                | 722 ------------------------
 arch/mips/ar7/prom.c                    | 256 ---------
 arch/mips/ar7/setup.c                   |  93 ---
 arch/mips/ar7/time.c                    |  31 -
 arch/mips/boot/compressed/uart-16550.c  |   5 -
 arch/mips/configs/ar7_defconfig         | 119 ----
 arch/mips/include/asm/mach-ar7/ar7.h    | 191 -------
 arch/mips/include/asm/mach-ar7/irq.h    |  16 -
 arch/mips/include/asm/mach-ar7/prom.h   |  12 -
 arch/mips/include/asm/mach-ar7/spaces.h |  22 -
 18 files changed, 2493 deletions(-)
 delete mode 100644 arch/mips/ar7/Makefile
 delete mode 100644 arch/mips/ar7/Platform
 delete mode 100644 arch/mips/ar7/clock.c
 delete mode 100644 arch/mips/ar7/gpio.c
 delete mode 100644 arch/mips/ar7/irq.c
 delete mode 100644 arch/mips/ar7/memory.c
 delete mode 100644 arch/mips/ar7/platform.c
 delete mode 100644 arch/mips/ar7/prom.c
 delete mode 100644 arch/mips/ar7/setup.c
 delete mode 100644 arch/mips/ar7/time.c
 delete mode 100644 arch/mips/configs/ar7_defconfig
 delete mode 100644 arch/mips/include/asm/mach-ar7/ar7.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/irq.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/prom.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/spaces.h

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index caad195ba5c1..a2311c4bce6a 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -2,7 +2,6 @@
 # All platforms listed in alphabetic order
 
 platform-$(CONFIG_MIPS_ALCHEMY)		+= alchemy/
-platform-$(CONFIG_AR7)			+= ar7/
 platform-$(CONFIG_ATH25)		+= ath25/
 platform-$(CONFIG_ATH79)		+= ath79/
 platform-$(CONFIG_BCM47XX)		+= bcm47xx/
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..76db82542519 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -202,28 +202,6 @@ config MIPS_ALCHEMY
 	select SYS_SUPPORTS_ZBOOT
 	select COMMON_CLK
 
-config AR7
-	bool "Texas Instruments AR7"
-	select BOOT_ELF32
-	select COMMON_CLK
-	select DMA_NONCOHERENT
-	select CEVT_R4K
-	select CSRC_R4K
-	select IRQ_MIPS_CPU
-	select NO_EXCEPT_FILL
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_HAS_EARLY_PRINTK
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_MIPS16
-	select SYS_SUPPORTS_ZBOOT_UART16550
-	select GPIOLIB
-	select VLYNQ
-	help
-	  Support for the Texas Instruments AR7 System-on-a-Chip
-	  family: TNETD7100, 7200 and 7300.
-
 config ATH25
 	bool "Atheros AR231x/AR531x SoC support"
 	select CEVT_R4K
diff --git a/arch/mips/ar7/Makefile b/arch/mips/ar7/Makefile
deleted file mode 100644
index cd51c6c6e686..000000000000
diff --git a/arch/mips/ar7/Platform b/arch/mips/ar7/Platform
deleted file mode 100644
index a9257cc01c3c..000000000000
diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
deleted file mode 100644
index c717acbc5506..000000000000
diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
deleted file mode 100644
index 4ed833b9cc2f..000000000000
diff --git a/arch/mips/ar7/irq.c b/arch/mips/ar7/irq.c
deleted file mode 100644
index f0a7942d393e..000000000000
diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
deleted file mode 100644
index ce8024c1a54e..000000000000
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
deleted file mode 100644
index 215149a85d83..000000000000
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
deleted file mode 100644
index 5810d3993fc6..000000000000
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
deleted file mode 100644
index 352d5dbc777c..000000000000
diff --git a/arch/mips/ar7/time.c b/arch/mips/ar7/time.c
deleted file mode 100644
index 72aa77d7087b..000000000000
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index 96d28f211121..09dcd2c561d9 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -13,11 +13,6 @@
 #define PORT(offset) (CKSEG1ADDR(UART_BASE) + (offset))
 #endif
 
-#ifdef CONFIG_AR7
-#include <ar7.h>
-#define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
-#endif
-
 #ifdef CONFIG_MACH_INGENIC
 #define INGENIC_UART_BASE_ADDR	(0x10030000 + 0x1000 * CONFIG_ZBOOT_INGENIC_UART)
 #define PORT(offset) (CKSEG1ADDR(INGENIC_UART_BASE_ADDR) + (4 * offset))
diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
deleted file mode 100644
index 329c60aa570a..000000000000
diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
deleted file mode 100644
index 1e8621a6afa3..000000000000
diff --git a/arch/mips/include/asm/mach-ar7/irq.h b/arch/mips/include/asm/mach-ar7/irq.h
deleted file mode 100644
index 46bb730ea970..000000000000
diff --git a/arch/mips/include/asm/mach-ar7/prom.h b/arch/mips/include/asm/mach-ar7/prom.h
deleted file mode 100644
index 9e1d20b06f57..000000000000
diff --git a/arch/mips/include/asm/mach-ar7/spaces.h b/arch/mips/include/asm/mach-ar7/spaces.h
deleted file mode 100644
index a004d94dfbdd..000000000000
-- 
2.35.1

