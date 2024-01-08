Return-Path: <linux-kernel+bounces-19632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9E2827010
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8433F283924
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB845948;
	Mon,  8 Jan 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfdbhMYu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD944C89;
	Mon,  8 Jan 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so1006930a12.0;
        Mon, 08 Jan 2024 05:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704721265; x=1705326065; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r6g5z9Mx4IxtW42MMxxjM9D6NLe62syXKXuO2xxI40=;
        b=UfdbhMYuz7Slksf7KjAEI3fNe+TuJvFAfDX6WyqgMQvjUSyuurAdWtLm62fryPbS5W
         LAetMQObo4ihXyubJQaHTLMVHMFEDZJf0AsPgJv6FjEdm+oF2tE/08ARAC1URlQEviHl
         wYiqlGkuc2WQL8sce2ALwlcN8X+WjKcmZV5qieIjg1DCsdD+7J7k44q4yzrPjCJyqQR7
         AhJ+V1DGHolE/AzvTovns2qFtkqxwBCPUgP+N9AgBAkwP1IYkP12vAdIa0mbLAGl7wh4
         XayWqm3W4PUcaPyqYBwTiZ3qmPUaBTCo4XMiWUzdi3vQbzloVJdxDOL4awJyoq86pT89
         Ewow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721265; x=1705326065;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r6g5z9Mx4IxtW42MMxxjM9D6NLe62syXKXuO2xxI40=;
        b=qryFBt/Sd0ydDO1rgO0FZicpd83H6aFc6SwV0iprbEg7kXG9vsEb9BkwjtiaciM4nB
         wLjkeWGoZ9NbZ/GDLWDDQMwP5Kt60Ld0i2sUKjnY6Vsa3LDOCOpLHHrMXkzbeAsOSS8h
         ncCWubdYKNInOVKFB6pjF2UCJvCaVWlm5KccE2GmboZuy9vrCdGpSQ+Cp1+pislnS5qt
         lS9HjnuJYv26rl+7e45gdmnguHMJkjrTN9zcpK12M8bWgsh9o3/vRoBfq11m1uI+ejMa
         KpoA5ioowVraITMt26n06dsBdIJnOFQFIKeM/FsqMnCOXAH8TWf9NoFFw5KNxMeiKMSP
         uiJg==
X-Gm-Message-State: AOJu0Yxbf1b8bUbQ0NDluszmNl4N2Bd8qxl9/1S81y2I7ggxTvSjwOa4
	RQSWt0NrxM3hEbWvXYlz1pY=
X-Google-Smtp-Source: AGHT+IHsSgTUHLYbaiUv5IWw6W2ekoAhScEgfGZkpNW1wQrT2vNPo2yxBdPLVFG/wdZpaBKadwDpqw==
X-Received: by 2002:a17:906:2c53:b0:a27:fdc1:59c6 with SMTP id f19-20020a1709062c5300b00a27fdc159c6mr5492095ejh.26.1704721265272;
        Mon, 08 Jan 2024 05:41:05 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:a060:7056:782e:5e26])
        by smtp.gmail.com with ESMTPSA id b1-20020a170906490100b00a26b36311ecsm4017896ejq.146.2024.01.08.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:41:04 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-input@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] vt: remove superfluous CONFIG_HW_CONSOLE
Date: Mon,  8 Jan 2024 14:41:02 +0100
Message-Id: <20240108134102.601-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The config HW_CONSOLE is always identical to the config VT and is not
visible in the kernel's build menuconfig. So, CONFIG_HW_CONSOLE is
redundant.

Replace all references to CONFIG_HW_CONSOLE with CONFIG_VT and remove
CONFIG_HW_CONSOLE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
I think this patch is best picked up by Greg rather than splitting it
in smaller pieces for m68k, amiga keyboard, fbdev etc.

Greg, if that is fine, could you pick this for the next merge window?

I was also considering to rename config VT_HW_CONSOLE_BINDING to
VT_CONSOLE_BINDING, as the dependency is on VT, not HW_CONSOLE, but
at the moment, that seemed more churn than value of clarification.

 arch/m68k/amiga/config.c        | 2 +-
 drivers/input/keyboard/amikbd.c | 6 +++---
 drivers/tty/Kconfig             | 7 +------
 drivers/tty/vt/Makefile         | 4 ++--
 drivers/video/fbdev/tgafb.c     | 2 +-
 include/linux/console.h         | 2 +-
 lib/Kconfig.kgdb                | 2 +-
 7 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 7791673e547b..99718f3dc686 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -846,6 +846,6 @@ static void amiga_get_hardware_list(struct seq_file *m)
  * The Amiga keyboard driver needs key_maps, but we cannot export it in
  * drivers/char/defkeymap.c, as it is autogenerated
  */
-#ifdef CONFIG_HW_CONSOLE
+#ifdef CONFIG_VT
 EXPORT_SYMBOL_GPL(key_maps);
 #endif
diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index e305c44cd0aa..ecfae0b0b6aa 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -26,7 +26,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Amiga keyboard driver");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_HW_CONSOLE
+#ifdef CONFIG_VT
 static unsigned char amikbd_keycode[0x78] __initdata = {
 	[0]	 = KEY_GRAVE,
 	[1]	 = KEY_1,
@@ -148,9 +148,9 @@ static void __init amikbd_init_console_keymaps(void)
 		memcpy(key_maps[i], temp_map, sizeof(temp_map));
 	}
 }
-#else /* !CONFIG_HW_CONSOLE */
+#else /* !CONFIG_VT */
 static inline void amikbd_init_console_keymaps(void) {}
-#endif /* !CONFIG_HW_CONSOLE */
+#endif /* !CONFIG_VT */
 
 static const char *amikbd_messages[8] = {
 	[0] = KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 5646dc6242cd..a45d423ad10f 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -75,14 +75,9 @@ config VT_CONSOLE_SLEEP
 	def_bool y
 	depends on VT_CONSOLE && PM_SLEEP
 
-config HW_CONSOLE
-	bool
-	depends on VT
-	default y
-
 config VT_HW_CONSOLE_BINDING
 	bool "Support for binding and unbinding console drivers"
-	depends on HW_CONSOLE
+	depends on VT
 	help
 	  The virtual terminal is the device that interacts with the physical
 	  terminal through console drivers. On these systems, at least one
diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
index b3dfe9d5717e..2c8ce8b592ed 100644
--- a/drivers/tty/vt/Makefile
+++ b/drivers/tty/vt/Makefile
@@ -5,9 +5,9 @@
 FONTMAPFILE = cp437.uni
 
 obj-$(CONFIG_VT)			+= vt_ioctl.o vc_screen.o \
-					   selection.o keyboard.o
+					   selection.o keyboard.o \
+					   vt.o defkeymap.o
 obj-$(CONFIG_CONSOLE_TRANSLATIONS)	+= consolemap.o consolemap_deftbl.o
-obj-$(CONFIG_HW_CONSOLE)		+= vt.o defkeymap.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c
diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index ca43774f3156..dccfc38cfbd5 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -380,7 +380,7 @@ tgafb_set_par(struct fb_info *info)
 		BT463_LOAD_ADDR(par, 0x0000);
 		TGA_WRITE_REG(par, BT463_PALETTE << 2, TGA_RAMDAC_SETUP_REG);
 
-#ifdef CONFIG_HW_CONSOLE
+#ifdef CONFIG_VT
 		for (i = 0; i < 16; i++) {
 			int j = color_table[i];
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 779d388af8a0..c129e4173dec 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -112,7 +112,7 @@ int con_is_bound(const struct consw *csw);
 int do_unregister_con_driver(const struct consw *csw);
 int do_take_over_console(const struct consw *sw, int first, int last, int deflt);
 void give_up_console(const struct consw *sw);
-#ifdef CONFIG_HW_CONSOLE
+#ifdef CONFIG_VT
 int con_debug_enter(struct vc_data *vc);
 int con_debug_leave(void);
 #else
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 3b9a44008433..b5c0e6576749 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -43,7 +43,7 @@ config KGDB_SERIAL_CONSOLE
 	tristate "KGDB: use kgdb over the serial console"
 	select CONSOLE_POLL
 	select MAGIC_SYSRQ
-	depends on TTY && HW_CONSOLE
+	depends on TTY && VT
 	default y
 	help
 	  Share a serial console with kgdb. Sysrq-g must be used
-- 
2.17.1


