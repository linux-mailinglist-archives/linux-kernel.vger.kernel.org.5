Return-Path: <linux-kernel+bounces-98001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D263877333
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3159F1C215BA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06A4AEC7;
	Sat,  9 Mar 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esMddYwo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CF4D9F4;
	Sat,  9 Mar 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008150; cv=none; b=uG+QOSiughEBJjDMem2cH44pI0m2moIQdiMmKrU6HkkjYe1eAnEtpZXpLH1mLyCkoU9EgkPjgE+3/kdqx/1641q4qO+VVHROYKQfjjMfWq79BsWwkQRl+na2PPniUM24X9GlNPdl3iA4zZqyLbEqFzinXBsMsjTrhlmeYxogzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008150; c=relaxed/simple;
	bh=Kow51FDdFQ9sABXz1hheGvGkXjR9DKaEV6lF8a+teQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tm5HI511VJGqyG8AkNITyNpH8hQU6xAgxuDZL3k1dMDSZuf9thwAKShxqJPrWZBt8m+Ry+z+7eIkkOKqJpekybGk0SUhLwMsynbtgIj0hT8lZUta6EGB68Krzy84JFA+yiCKnMBFNvM7xn/oOOjUI3BJtYXFnR0gwS0ok3ElDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esMddYwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46138C4166C;
	Sat,  9 Mar 2024 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008150;
	bh=Kow51FDdFQ9sABXz1hheGvGkXjR9DKaEV6lF8a+teQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=esMddYwo3g3YY2dfA7Ru36ui/e3MInaqay9c0xiadYJjUG42CDkN4BFII7tWniQOe
	 IxnUD+7q7fOPloR/WrEWiexZNW8Tw1n+QVbt0MVliaC6NQRhHFy3zCN4tF2RB+Gkd/
	 w/AzRZjc82obo8C/ZDpsBHY0I3n7G7mEG1bG9on+DJYchXbGzBGLZuD5sIEr9SYaGU
	 G0OM2KGNENOvJTf81U5eEHPKNK6L4vkArZOwGncJpIm2smD1PwS1dYs0Qlm8xSWVqI
	 BNHykNpimuRCJ21UY3pKlhvpIRSi4M+0P/weNFm62OtPO5XrUwBmWo2eGyhHfb6lMF
	 dP4gC9VprRUFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379FAC54E64;
	Sat,  9 Mar 2024 18:15:50 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 09 Mar 2024 19:15:47 +0100
Subject: [PATCH v2 26/28] sparc32: Drop sbus support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-sunset-v2-26-f09912574d2c@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
In-Reply-To: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Kjetil Oftedal <oftedal@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710008145; l=8477;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=xmw2JGzs8vom6g85W+svc/tLgf9CzP5XaCDa0acDElc=; =?utf-8?q?b=3DtXm1a+L8ILut?=
 =?utf-8?q?vbOELIKIeTKReHGphEFku8IViIgSxxlPrltYOxWESeIP0NwXYND/NlbaVSZbSzKl?=
 5lsUlmt1B4tGT0KHJJBfFMurxqXeu33g4TsYYnV5DrG9ITYNU8O4
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

LEON do not have an sbus - so drop support for that for sparc32.
Fix a few Kconfig expressions to use CONFIG_SBUS rather than SPARC
as only SPARC64 has an sbus now.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/Kconfig               |  4 +-
 arch/sparc/include/asm/fb.h      |  8 ++--
 arch/sparc/include/asm/io_32.h   | 83 ----------------------------------------
 arch/sparc/kernel/ioport.c       | 49 ------------------------
 arch/sparc/kernel/of_device_32.c | 14 -------
 drivers/video/fbdev/Kconfig      |  2 +-
 sound/sparc/Kconfig              |  1 +
 7 files changed, 9 insertions(+), 152 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e4e2548c1f1f..e7a62cc06c51 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -388,11 +388,11 @@ endmenu
 menu "Bus options (PCI etc.)"
 config SBUS
 	bool
-	default y
+	default y if SPARC64
 
 config SBUSCHAR
 	bool
-	default y
+	default y if SPARC64
 
 config SUN_LDOMS
 	bool "Sun Logical Domains support"
diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index 24440c0fda49..15b007875457 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -8,6 +8,9 @@
 
 struct fb_info;
 
+int fb_is_primary_device(struct fb_info *info);
+#define fb_is_primary_device fb_is_primary_device
+
 #ifdef CONFIG_SPARC32
 static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 					  unsigned long vm_start, unsigned long vm_end,
@@ -18,9 +21,7 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 #define pgprot_framebuffer pgprot_framebuffer
 #endif
 
-int fb_is_primary_device(struct fb_info *info);
-#define fb_is_primary_device fb_is_primary_device
-
+#ifdef CONFIG_SPARC64
 static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
 	sbus_memcpy_fromio(to, from, n);
@@ -38,6 +39,7 @@ static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
 	sbus_memset_io(addr, c, n);
 }
 #define fb_memset fb_memset_io
+#endif
 
 #include <asm-generic/fb.h>
 
diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 83abe709d120..b9f280ee1b11 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -56,78 +56,6 @@ static inline void _memcpy_toio(volatile void __iomem *dst, const void *src,
 	}
 }
 
-/*
- * SBus accessors.
- *
- * SBus has only one, memory mapped, I/O space.
- * We do not need to flip bytes for SBus of course.
- */
-static inline u8 sbus_readb(const volatile void __iomem *addr)
-{
-	return *(__force volatile u8 *)addr;
-}
-
-static inline u16 sbus_readw(const volatile void __iomem *addr)
-{
-	return *(__force volatile u16 *)addr;
-}
-
-static inline u32 sbus_readl(const volatile void __iomem *addr)
-{
-	return *(__force volatile u32 *)addr;
-}
-
-static inline void sbus_writeb(u8 b, volatile void __iomem *addr)
-{
-	*(__force volatile u8 *)addr = b;
-}
-
-static inline void sbus_writew(u16 w, volatile void __iomem *addr)
-{
-	*(__force volatile u16 *)addr = w;
-}
-
-static inline void sbus_writel(u32 l, volatile void __iomem *addr)
-{
-	*(__force volatile u32 *)addr = l;
-}
-
-static inline void sbus_memset_io(volatile void __iomem *__dst, int c,
-                                  __kernel_size_t n)
-{
-	while(n--) {
-		sbus_writeb(c, __dst);
-		__dst++;
-	}
-}
-
-static inline void sbus_memcpy_fromio(void *dst,
-                                      const volatile void __iomem *src,
-                                      __kernel_size_t n)
-{
-	char *d = dst;
-
-	while (n--) {
-		char tmp = sbus_readb(src);
-		*d++ = tmp;
-		src++;
-	}
-}
-
-static inline void sbus_memcpy_toio(volatile void __iomem *dst,
-                                    const void *src,
-                                    __kernel_size_t n)
-{
-	const char *s = src;
-	volatile void __iomem *d = dst;
-
-	while (n--) {
-		char tmp = *s++;
-		sbus_writeb(tmp, d);
-		d++;
-	}
-}
-
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr);
 void ioport_unmap(void __iomem *);
@@ -136,17 +64,6 @@ void ioport_unmap(void __iomem *);
 struct pci_dev;
 void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
-static inline int sbus_can_dma_64bit(void)
-{
-	return 0;
-}
-static inline int sbus_can_burst64(void)
-{
-	return 0;
-}
-struct device;
-void sbus_set_sbus64(struct device *, int);
-
 #define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
 
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 9c4c72775274..97b836f3be25 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -55,8 +55,6 @@ static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
     unsigned long size, char *name);
 static void _sparc_free_io(struct resource *res);
 
-static void register_proc_sparc_ioport(void);
-
 /* This points to the next to use virtual memory for DVMA mappings */
 static struct resource _sparc_dvma = {
 	.name = "sparc_dvma", .start = DVMA_VADDR, .end = DVMA_END - 1
@@ -279,25 +277,6 @@ bool sparc_dma_free_resource(void *cpu_addr, size_t size)
 	return true;
 }
 
-#ifdef CONFIG_SBUS
-
-void sbus_set_sbus64(struct device *dev, int x)
-{
-	printk("sbus_set_sbus64: unsupported\n");
-}
-EXPORT_SYMBOL(sbus_set_sbus64);
-
-static int __init sparc_register_ioport(void)
-{
-	register_proc_sparc_ioport();
-
-	return 0;
-}
-
-arch_initcall(sparc_register_ioport);
-
-#endif /* CONFIG_SBUS */
-
 /*
  * IIep is write-through, not flushing on cpu to device transfer.
  *
@@ -310,31 +289,3 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	if (dir != DMA_TO_DEVICE && !sparc_leon3_snooping_enabled())
 		leon_flush_dcache_all();
 }
-
-#ifdef CONFIG_PROC_FS
-
-static int sparc_io_proc_show(struct seq_file *m, void *v)
-{
-	struct resource *root = m->private, *r;
-	const char *nm;
-
-	for (r = root->child; r != NULL; r = r->sibling) {
-		if ((nm = r->name) == NULL) nm = "???";
-		seq_printf(m, "%016llx-%016llx: %s\n",
-				(unsigned long long)r->start,
-				(unsigned long long)r->end, nm);
-	}
-
-	return 0;
-}
-#endif /* CONFIG_PROC_FS */
-
-static void register_proc_sparc_ioport(void)
-{
-#ifdef CONFIG_PROC_FS
-	proc_create_single_data("io_map", 0, NULL, sparc_io_proc_show,
-			&sparc_iomap);
-	proc_create_single_data("dvma_map", 0, NULL, sparc_io_proc_show,
-			&_sparc_dvma);
-#endif
-}
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index ddb3b197d5e4..99ec26782bcc 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -96,11 +96,6 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 	return flags;
 }
 
-static unsigned long of_bus_sbus_get_flags(const u32 *addr, unsigned long flags)
-{
-	return IORESOURCE_MEM;
-}
-
  /*
  * AMBAPP bus specific translator
  */
@@ -145,15 +140,6 @@ static struct of_bus of_busses[] = {
 		.map = of_bus_pci_map,
 		.get_flags = of_bus_pci_get_flags,
 	},
-	/* SBUS */
-	{
-		.name = "sbus",
-		.addr_prop_name = "reg",
-		.match = of_bus_sbus_match,
-		.count_cells = of_bus_sbus_count_cells,
-		.map = of_bus_default_map,
-		.get_flags = of_bus_sbus_get_flags,
-	},
 	/* AMBA */
 	{
 		.name = "ambapp",
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 2d0bcc1d786e..a74f7fd3ba0c 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -492,7 +492,7 @@ config FB_GBE_MEM
 
 config FB_SBUS
 	bool "SBUS and UPA framebuffers"
-	depends on (FB = y) && SPARC
+	depends on (FB = y) && SBUS
 	help
 	  Say Y if you want support for SBUS or UPA based frame buffer device.
 
diff --git a/sound/sparc/Kconfig b/sound/sparc/Kconfig
index 59b9f16e8dea..af2fb963a455 100644
--- a/sound/sparc/Kconfig
+++ b/sound/sparc/Kconfig
@@ -4,6 +4,7 @@
 menuconfig SND_SPARC
 	bool "Sparc sound devices"
 	depends on SPARC
+	depends on SBUS
 	default y
 	help
 	  Support for sound devices specific to Sun SPARC architectures.

-- 
2.34.1


