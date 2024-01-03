Return-Path: <linux-kernel+bounces-16111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC1823915
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3151F25303
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BBA208D3;
	Wed,  3 Jan 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m69kSwRU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E4208C3;
	Wed,  3 Jan 2024 23:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C128C433CC;
	Wed,  3 Jan 2024 23:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704323786;
	bh=TiGojyRn+72MZnF/6JWr/zsbKcaDxGZyoQWT839j7Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m69kSwRUibEfPrLOxy+NryIUgoLNLsS9urWB6sqUl+QiUaJj74GDYiBO1EW8ShK/i
	 504Nfr29qbf+j+UAkEehZIZXrUW+6JvSw4fRBj7eZC0QlEIgUCH7KFL95e3aHLotpr
	 VI3pRu8EI6wftC6d8QO9xydIwF4TLwbzaac+M7JuVpSBuwPVLsx1rfkNDeo/8LdBJo
	 7efOTT8RX85VCNYCRMvj13v7xXP2HHVjVde7HvpQolHw5v9aiUC+x0M589KjYnfMxJ
	 LGgAd7znC6HcRnuL8pPWOcwQNLSyjllb0TYjFcQV2uAShtOikyRWyLQK4NnlJlSmKj
	 foYgotyILAKUQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-mips@vger.kernel.org
Subject: [PATCH 6/8] MIPS: Fix typos
Date: Wed,  3 Jan 2024 17:16:03 -0600
Message-Id: <20240103231605.1801364-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103231605.1801364-1-helgaas@kernel.org>
References: <20240103231605.1801364-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, most reported by "codespell arch/mips".  Only touches comments,
no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/bcm47xx/buttons.c                            | 6 +++---
 arch/mips/bcm63xx/clk.c                                | 4 ++--
 arch/mips/boot/compressed/dbg.c                        | 2 +-
 arch/mips/boot/elf2ecoff.c                             | 2 +-
 arch/mips/cavium-octeon/csrc-octeon.c                  | 2 +-
 arch/mips/cavium-octeon/executive/cvmx-boot-vector.c   | 2 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c       | 2 +-
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c     | 4 ++--
 arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c   | 2 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c           | 2 +-
 arch/mips/cavium-octeon/octeon-platform.c              | 2 +-
 arch/mips/fw/arc/promlib.c                             | 6 +++---
 arch/mips/include/asm/debug.h                          | 2 +-
 arch/mips/include/asm/io.h                             | 4 ++--
 arch/mips/include/asm/mach-au1x00/au1000_dma.h         | 2 +-
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h        | 2 +-
 arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h  | 2 +-
 arch/mips/include/asm/mach-loongson64/loongson_hwmon.h | 2 +-
 arch/mips/include/asm/mach-loongson64/loongson_regs.h  | 2 +-
 arch/mips/include/asm/mach-malta/spaces.h              | 4 ++--
 arch/mips/include/asm/mips-boards/bonito64.h           | 2 +-
 arch/mips/include/asm/mips-cpc.h                       | 2 +-
 arch/mips/include/asm/mipsregs.h                       | 4 ++--
 arch/mips/include/asm/octeon/cvmx-bootinfo.h           | 2 +-
 arch/mips/include/asm/octeon/cvmx-cmd-queue.h          | 6 +++---
 arch/mips/include/asm/octeon/cvmx-pko.h                | 2 +-
 arch/mips/include/asm/octeon/cvmx-pow.h                | 4 ++--
 arch/mips/include/asm/octeon/octeon-model.h            | 4 ++--
 arch/mips/include/asm/page.h                           | 2 +-
 arch/mips/include/asm/pci.h                            | 2 +-
 arch/mips/include/asm/pgtable-bits.h                   | 2 +-
 arch/mips/include/asm/sgi/mc.h                         | 2 +-
 arch/mips/include/asm/sn/klconfig.h                    | 2 +-
 arch/mips/include/asm/sync.h                           | 2 +-
 arch/mips/include/asm/thread_info.h                    | 2 +-
 arch/mips/include/asm/timex.h                          | 2 +-
 arch/mips/include/asm/vdso/vdso.h                      | 2 +-
 arch/mips/include/uapi/asm/mman.h                      | 2 +-
 arch/mips/include/uapi/asm/msgbuf.h                    | 2 +-
 arch/mips/kernel/cpu-probe.c                           | 2 +-
 arch/mips/kernel/kprobes.c                             | 2 +-
 arch/mips/kernel/relocate.c                            | 2 +-
 arch/mips/kernel/relocate_kernel.S                     | 2 +-
 arch/mips/kernel/setup.c                               | 2 +-
 arch/mips/kernel/signal.c                              | 2 +-
 arch/mips/kernel/traps.c                               | 2 +-
 arch/mips/kernel/vpe.c                                 | 4 ++--
 arch/mips/kvm/emulate.c                                | 2 +-
 arch/mips/loongson2ef/common/platform.c                | 2 +-
 arch/mips/loongson64/smp.c                             | 2 +-
 arch/mips/mm/c-r4k.c                                   | 2 +-
 arch/mips/mm/cex-gen.S                                 | 2 +-
 arch/mips/mm/tlb-r3k.c                                 | 2 +-
 arch/mips/mm/tlb-r4k.c                                 | 2 +-
 arch/mips/mm/tlbex.c                                   | 4 ++--
 arch/mips/net/bpf_jit_comp32.c                         | 2 +-
 arch/mips/pci/ops-loongson2.c                          | 2 +-
 arch/mips/pci/pci-alchemy.c                            | 2 +-
 arch/mips/pci/pci-ar2315.c                             | 2 +-
 arch/mips/pci/pci-lantiq.c                             | 2 +-
 arch/mips/pci/pci-octeon.c                             | 2 +-
 arch/mips/pci/pci-xtalk-bridge.c                       | 2 +-
 arch/mips/pci/pcie-octeon.c                            | 2 +-
 arch/mips/ralink/mt7621.c                              | 2 +-
 arch/mips/txx9/generic/pci.c                           | 2 +-
 65 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 437a737c01dd..46994f9bb821 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -147,21 +147,21 @@ static const struct gpio_keys_button
 bcm47xx_buttons_buffalo_whr_g125[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
-	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode swtich */
+	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode switch */
 };
 
 static const struct gpio_keys_button
 bcm47xx_buttons_buffalo_whr_g54s[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY_H(4, KEY_RESTART),
-	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode swtich */
+	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode switch */
 };
 
 static const struct gpio_keys_button
 bcm47xx_buttons_buffalo_whr_hp_g54[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
-	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode swtich */
+	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode switch */
 };
 
 static const struct gpio_keys_button
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 86a6e2590866..3144965fb7dc 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -174,7 +174,7 @@ static void enetsw_set(struct clk *clk, int enable)
 	}
 
 	if (enable) {
-		/* reset switch core afer clock change */
+		/* reset switch core after clock change */
 		bcm63xx_core_set_reset(BCM63XX_RESET_ENETSW, 1);
 		msleep(10);
 		bcm63xx_core_set_reset(BCM63XX_RESET_ENETSW, 0);
@@ -304,7 +304,7 @@ static void xtm_set(struct clk *clk, int enable)
 	bcm_hwclock_set(CKCTL_6368_SAR_EN, enable);
 
 	if (enable) {
-		/* reset sar core afer clock change */
+		/* reset sar core after clock change */
 		bcm63xx_core_set_reset(BCM63XX_RESET_SAR, 1);
 		mdelay(1);
 		bcm63xx_core_set_reset(BCM63XX_RESET_SAR, 0);
diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
index f6728a8fd1c3..98dfb2e59dfe 100644
--- a/arch/mips/boot/compressed/dbg.c
+++ b/arch/mips/boot/compressed/dbg.c
@@ -3,7 +3,7 @@
  * MIPS-specific debug support for pre-boot environment
  *
  * NOTE: putc() is board specific, if your board have a 16550 compatible uart,
- * please select SYS_SUPPORTS_ZBOOT_UART16550 for your machine. othewise, you
+ * please select SYS_SUPPORTS_ZBOOT_UART16550 for your machine. otherwise, you
  * need to implement your own putc().
  */
 #include <linux/compiler.h>
diff --git a/arch/mips/boot/elf2ecoff.c b/arch/mips/boot/elf2ecoff.c
index 6972b97235da..549c5d6ef6d7 100644
--- a/arch/mips/boot/elf2ecoff.c
+++ b/arch/mips/boot/elf2ecoff.c
@@ -443,7 +443,7 @@ int main(int argc, char *argv[])
 	efh.f_symptr = 0;
 	efh.f_nsyms = 0;
 	efh.f_opthdr = sizeof eah;
-	efh.f_flags = 0x100f;	/* Stripped, not sharable. */
+	efh.f_flags = 0x100f;	/* Stripped, not shareable. */
 
 	memset(esecs, 0, sizeof esecs);
 	strcpy(esecs[0].s_name, ".text");
diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 124817609ce0..af62a210a40b 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -113,7 +113,7 @@ static struct clocksource clocksource_mips = {
 
 unsigned long long notrace sched_clock(void)
 {
-	/* 64-bit arithmatic can overflow, so use 128-bit.  */
+	/* 64-bit arithmetic can overflow, so use 128-bit.  */
 	u64 t1, t2, t3;
 	unsigned long long rv;
 	u64 mult = clocksource_mips.mult;
diff --git a/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c b/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
index b7019d21808e..76446db66def 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
@@ -143,7 +143,7 @@ static void cvmx_boot_vector_init(void *mem)
 		uint64_t v = _cvmx_bootvector_data[i];
 
 		if (OCTEON_IS_OCTEON1PLUS() && (i == 0 || i == 7))
-			v &= 0xffffffff00000000ull; /* KScratch not availble. */
+			v &= 0xffffffff00000000ull; /* KScratch not available */
 		cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, i * 8);
 		cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, v);
 	}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 334bf8e577e5..628ebdf4b9c5 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -264,7 +264,7 @@ int64_t cvmx_bootmem_phy_alloc(uint64_t req_size, uint64_t address_min,
 	 * Convert !0 address_min and 0 address_max to special case of
 	 * range that specifies an exact memory block to allocate.  Do
 	 * this before other checks and adjustments so that this
-	 * tranformation will be validated.
+	 * transformation will be validated.
 	 */
 	if (address_min && !address_max)
 		address_max = address_min + req_size;
diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
index aa7bbf8d0df5..042a6bc44b5c 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
@@ -192,7 +192,7 @@ cvmx_cmd_queue_result_t cvmx_cmd_queue_initialize(cvmx_cmd_queue_id_t queue_id,
 }
 
 /*
- * Shutdown a queue a free it's command buffers to the FPA. The
+ * Shutdown a queue and free its command buffers to the FPA. The
  * hardware connected to the queue must be stopped before this
  * function is called.
  *
@@ -285,7 +285,7 @@ int cvmx_cmd_queue_length(cvmx_cmd_queue_id_t queue_id)
 
 /*
  * Return the command buffer to be written to. The purpose of this
- * function is to allow CVMX routine access t othe low level buffer
+ * function is to allow CVMX routine access to the low level buffer
  * for initial hardware setup. User applications should not call this
  * function directly.
  *
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
index 607b4e659579..1fceb7fd2c94 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
@@ -103,7 +103,7 @@ uint32_t cvmx_helper_qlm_jtag_shift(int qlm, int bits, uint32_t data)
 /**
  * Shift long sequences of zeros into the QLM JTAG chain. It is
  * common to need to shift more than 32 bits of zeros into the
- * chain. This function is a convience wrapper around
+ * chain. This function is a convenience wrapper around
  * cvmx_helper_qlm_jtag_shift() to shift more than 32 bits of
  * zeros at a time.
  *
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 15faca494c80..6e70b859a0ac 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -615,7 +615,7 @@ int cvmx_pko_rate_limit_bits(int port, uint64_t bits_s, int burst)
 	/*
 	 * Each packet has a 12 bytes of interframe gap, an 8 byte
 	 * preamble, and a 4 byte CRC. These are not included in the
-	 * per word count. Multiply by 8 to covert to bits and divide
+	 * per word count. Multiply by 8 to convert to bits and divide
 	 * by 256 for limit granularity.
 	 */
 	pko_mem_port_rate0.s.rate_pkt = (12 + 8 + 4) * 8 * tokens_per_bit / 256;
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index f76783c24338..5e1dd4e6e82f 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -973,7 +973,7 @@ int __init octeon_prune_device_tree(void)
 			 * zero.
 			 */
 
-			/* Asume that CS1 immediately follows. */
+			/* Assume that CS1 immediately follows. */
 			mio_boot_reg_cfg.u64 =
 				cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs + 1));
 			region1_base = mio_boot_reg_cfg.s.base << 16;
diff --git a/arch/mips/fw/arc/promlib.c b/arch/mips/fw/arc/promlib.c
index 5e9e840a9314..93e1e70393ee 100644
--- a/arch/mips/fw/arc/promlib.c
+++ b/arch/mips/fw/arc/promlib.c
@@ -15,11 +15,11 @@
 /*
  * For 64bit kernels working with a 32bit ARC PROM pointer arguments
  * for ARC calls need to reside in CKEG0/1. But as soon as the kernel
- * switches to it's first kernel thread stack is set to an address in
+ * switches to its first kernel thread stack is set to an address in
  * XKPHYS, so anything on stack can't be used anymore. This is solved
- * by using a * static declartion variables are put into BSS, which is
+ * by using a * static declaration variables are put into BSS, which is
  * linked to a CKSEG0 address. Since this is only used on UP platforms
- * there is not spinlock needed
+ * there is no spinlock needed
  */
 #define O32_STATIC	static
 #else
diff --git a/arch/mips/include/asm/debug.h b/arch/mips/include/asm/debug.h
index c7013e1cb53f..e70392429246 100644
--- a/arch/mips/include/asm/debug.h
+++ b/arch/mips/include/asm/debug.h
@@ -10,7 +10,7 @@
 
 /*
  * mips_debugfs_dir corresponds to the "mips" directory at the top level
- * of the DebugFS hierarchy. MIPS-specific DebugFS entires should be
+ * of the DebugFS hierarchy. MIPS-specific DebugFS entries should be
  * placed beneath this directory.
  */
 extern struct dentry *mips_debugfs_dir;
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 062dd4e6b954..bba327dc1226 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -179,7 +179,7 @@ void iounmap(const volatile void __iomem *addr);
  * address is not guaranteed to be usable directly as a virtual
  * address.
  *
- * This version of ioremap ensures that the memory is marked cachable by
+ * This version of ioremap ensures that the memory is marked cacheable by
  * the CPU.  Also enables full write-combining.	 Useful for some
  * memory-like regions on I/O busses.
  */
@@ -197,7 +197,7 @@ void iounmap(const volatile void __iomem *addr);
  * address is not guaranteed to be usable directly as a virtual
  * address.
  *
- * This version of ioremap ensures that the memory is marked uncachable
+ * This version of ioremap ensures that the memory is marked uncacheable
  * but accelerated by means of write-combining feature. It is specifically
  * useful for PCIe prefetchable windows, which may vastly improve a
  * communications performance. If it was determined on boot stage, what
diff --git a/arch/mips/include/asm/mach-au1x00/au1000_dma.h b/arch/mips/include/asm/mach-au1x00/au1000_dma.h
index 0a0cd4270c6f..b82e513c8523 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000_dma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000_dma.h
@@ -259,7 +259,7 @@ static inline void set_dma_mode(unsigned int dmanr, unsigned int mode)
 	if (!chan)
 		return;
 	/*
-	 * set_dma_mode is only allowed to change endianess, direction,
+	 * set_dma_mode is only allowed to change endianness, direction,
 	 * transfer size, device FIFO width, and coherency settings.
 	 * Make sure anything else is masked off.
 	 */
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 82bc2766e2ec..d820b481ac56 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -435,7 +435,7 @@ static inline void alchemy_gpio2_disable_int(int gpio2)
 /**
  * alchemy_gpio2_enable -  Activate GPIO2 block.
  *
- * The GPIO2 block must be enabled excplicitly to work.	 On systems
+ * The GPIO2 block must be enabled explicitly to work.	 On systems
  * where this isn't done by the bootloader, this macro can be used.
  */
 static inline void alchemy_gpio2_enable(void)
diff --git a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
index 5855ba1bd1ec..40eaa72e54d0 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
@@ -55,7 +55,7 @@ extern __iomem void *ltq_sys1_membase;
 #define ltq_sys1_w32_mask(clear, set, reg)   \
 	ltq_sys1_w32((ltq_sys1_r32(reg) & ~(clear)) | (set), reg)
 
-/* allow the gpio and pinctrl drivers to talk to eachother */
+/* allow the gpio and pinctrl drivers to talk to each other */
 extern int pinctrl_falcon_get_range_size(int id);
 extern void pinctrl_falcon_add_gpio_range(struct pinctrl_gpio_range *range);
 
diff --git a/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h b/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
index 545f91f2ae16..721eafc4644e 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
@@ -42,7 +42,7 @@ struct loongson_fan_policy {
 	/* period between two check. (Unit: S) */
 	u8	adjust_period;
 
-	/* fan adjust usually depend on a temprature input */
+	/* fan adjust usually depend on a temperature input */
 	get_temp_fun	depend_temp;
 
 	/* up_step/down_step used when type is STEP_SPEED_POLICY */
diff --git a/arch/mips/include/asm/mach-loongson64/loongson_regs.h b/arch/mips/include/asm/mach-loongson64/loongson_regs.h
index b5be7511f6cd..fec767507604 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson_regs.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson_regs.h
@@ -227,7 +227,7 @@ static inline void csr_writeq(u64 val, u32 reg)
 #define LOONGSON_CSR_NODECNT	0x408
 #define LOONGSON_CSR_CPUTEMP	0x428
 
-/* PerCore CSR, only accessable by local cores */
+/* PerCore CSR, only accessible by local cores */
 #define LOONGSON_CSR_IPI_STATUS	0x1000
 #define LOONGSON_CSR_IPI_EN	0x1004
 #define LOONGSON_CSR_IPI_SET	0x1008
diff --git a/arch/mips/include/asm/mach-malta/spaces.h b/arch/mips/include/asm/mach-malta/spaces.h
index d7e54971ec66..1ce4ba97852f 100644
--- a/arch/mips/include/asm/mach-malta/spaces.h
+++ b/arch/mips/include/asm/mach-malta/spaces.h
@@ -23,13 +23,13 @@
  * The kernel is still located in 0x80000000(kseg0). However,
  * the physical mask has been shifted to 0x80000000 which exploits the alias
  * on the Malta board. As a result of which, we override the __pa_symbol
- * to peform direct mapping from virtual to physical addresses. In other
+ * to perform direct mapping from virtual to physical addresses. In other
  * words, the 0x80000000 virtual address maps to 0x80000000 physical address
  * which in turn aliases to 0x0. We do this in order to be able to use a flat
  * 2GB of memory (0x80000000 - 0xffffffff) so we can avoid the I/O hole in
  * 0x10000000 - 0x1fffffff.
  * The last 64KB of physical memory are reserved for correct HIGHMEM
- * macros arithmetics.
+ * macros arithmetic.
  *
  */
 
diff --git a/arch/mips/include/asm/mips-boards/bonito64.h b/arch/mips/include/asm/mips-boards/bonito64.h
index 5368891d424b..31a31fe78d77 100644
--- a/arch/mips/include/asm/mips-boards/bonito64.h
+++ b/arch/mips/include/asm/mips-boards/bonito64.h
@@ -16,7 +16,7 @@
  */
 
 /* Revision 1.48 autogenerated on 08/17/99 15:20:01 */
-/* This bonito64 version editted from bonito.h Revision 1.48 on 11/09/00 */
+/* This bonito64 version edited from bonito.h Revision 1.48 on 11/09/00 */
 
 #ifndef _ASM_MIPS_BOARDS_BONITO64_H
 #define _ASM_MIPS_BOARDS_BONITO64_H
diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index b54453f1648c..5f3a7a9f42bf 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -22,7 +22,7 @@ extern void __iomem *mips_cpc_base;
  *                              the CPC
  *
  * Returns the default physical base address of the Cluster Power Controller
- * memory mapped registers. This is platform dependant & must therefore be
+ * memory mapped registers. This is platform dependent & must therefore be
  * implemented per-platform.
  */
 extern phys_addr_t mips_cpc_default_phys_base(void);
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 2d53704d9f24..ec58cb76d076 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -98,7 +98,7 @@
 
 /*
  * R4640/R4650 cp0 register names.  These registers are listed
- * here only for completeness; without MMU these CPUs are not useable
+ * here only for completeness; without MMU these CPUs are not usable
  * by Linux.  A future ELKS port might take make Linux run on them
  * though ...
  */
@@ -461,7 +461,7 @@
 #define EXCCODE_THREAD		25	/* Thread exceptions (MT) */
 #define EXCCODE_DSPDIS		26	/* DSP disabled exception */
 #define EXCCODE_GE		27	/* Virtualized guest exception (VZ) */
-#define EXCCODE_CACHEERR	30	/* Parity/ECC occured on a core */
+#define EXCCODE_CACHEERR	30	/* Parity/ECC occurred on a core */
 
 /* Implementation specific trap codes used by MIPS cores */
 #define MIPS_EXCCODE_TLBPAR	16	/* TLB parity error exception */
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index c1c0b3230e0a..028bf1d6daee 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -114,7 +114,7 @@ struct cvmx_bootinfo {
 
 	/*
 	 * flags indicating various configuration options.  These
-	 * flags supercede the 'flags' variable and should be used
+	 * flags supersede the 'flags' variable and should be used
 	 * instead if available.
 	 */
 	uint32_t config_flags;
diff --git a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h b/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
index a07a36f7d814..67e1b2162b19 100644
--- a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
+++ b/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
@@ -145,7 +145,7 @@ typedef struct {
 /**
  * This structure contains the global state of all command queues.
  * It is stored in a bootmem named block and shared by all
- * applications running on Octeon. Tickets are stored in a differnet
+ * applications running on Octeon. Tickets are stored in a different
  * cache line that queue information to reduce the contention on the
  * ll/sc used to get a ticket. If this is not the case, the update
  * of queue state causes the ll/sc to fail quite often.
@@ -172,7 +172,7 @@ cvmx_cmd_queue_result_t cvmx_cmd_queue_initialize(cvmx_cmd_queue_id_t queue_id,
 						  int pool_size);
 
 /**
- * Shutdown a queue a free it's command buffers to the FPA. The
+ * Shutdown a queue and free its command buffers to the FPA. The
  * hardware connected to the queue must be stopped before this
  * function is called.
  *
@@ -194,7 +194,7 @@ int cvmx_cmd_queue_length(cvmx_cmd_queue_id_t queue_id);
 
 /**
  * Return the command buffer to be written to. The purpose of this
- * function is to allow CVMX routine access t othe low level buffer
+ * function is to allow CVMX routine access to the low level buffer
  * for initial hardware setup. User applications should not call this
  * function directly.
  *
diff --git a/arch/mips/include/asm/octeon/cvmx-pko.h b/arch/mips/include/asm/octeon/cvmx-pko.h
index 5fec8476e421..f18a7f24daf8 100644
--- a/arch/mips/include/asm/octeon/cvmx-pko.h
+++ b/arch/mips/include/asm/octeon/cvmx-pko.h
@@ -91,7 +91,7 @@ typedef enum {
 } cvmx_pko_status_t;
 
 /**
- * This enumeration represents the differnet locking modes supported by PKO.
+ * This enumeration represents the different locking modes supported by PKO.
  */
 typedef enum {
 	/*
diff --git a/arch/mips/include/asm/octeon/cvmx-pow.h b/arch/mips/include/asm/octeon/cvmx-pow.h
index a3b23811e0c3..21b4378244fa 100644
--- a/arch/mips/include/asm/octeon/cvmx-pow.h
+++ b/arch/mips/include/asm/octeon/cvmx-pow.h
@@ -1342,7 +1342,7 @@ static inline void cvmx_pow_tag_sw_wait(void)
  * This function does NOT wait for previous tag switches to complete,
  * so the caller must ensure that there is not a pending tag switch.
  *
- * @wait:   When set, call stalls until work becomes avaiable, or times out.
+ * @wait:   When set, call stalls until work becomes available, or times out.
  *		 If not set, returns immediately.
  *
  * Returns: the WQE pointer from POW. Returns NULL if no work
@@ -1376,7 +1376,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync_nocheck(cvmx_pow_wait_
  * This function waits for any previous tag switch to complete before
  * requesting the new work.
  *
- * @wait:   When set, call stalls until work becomes avaiable, or times out.
+ * @wait:   When set, call stalls until work becomes available, or times out.
  *		 If not set, returns immediately.
  *
  * Returns: the WQE pointer from POW. Returns NULL if no work
diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
index 6c68517c2770..e53b61a8e32f 100644
--- a/arch/mips/include/asm/octeon/octeon-model.h
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -54,7 +54,7 @@
 #define OM_CHECK_SUBMODEL	  0x02000000
 /* Match all models previous than the one specified */
 #define OM_MATCH_PREVIOUS_MODELS  0x04000000
-/* Ignores the minor revison on newer parts */
+/* Ignores the minor revision on newer parts */
 #define OM_IGNORE_MINOR_REVISION  0x08000000
 #define OM_FLAG_MASK		  0xff000000
 
@@ -226,7 +226,7 @@
 #define OCTEON_CN52XX_PASS2	OCTEON_CN52XX_PASS2_X
 
 /*
- * CN3XXX models with old revision enconding
+ * CN3XXX models with old revision encoding
  */
 #define OCTEON_CN38XX_PASS1	0x000d0000
 #define OCTEON_CN38XX_PASS2	0x000d0001
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 5978a8dfb917..ef9585d96f6b 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -173,7 +173,7 @@ static inline unsigned long ___pa(unsigned long x)
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		/*
 		 * For MIPS64 the virtual address may either be in one of
-		 * the compatibility segements ckseg0 or ckseg1, or it may
+		 * the compatibility segments ckseg0 or ckseg1, or it may
 		 * be in xkphys.
 		 */
 		return x < CKSEG0 ? XPHYSADDR(x) : CPHYSADDR(x);
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 3fd6e22c108b..d993df6302dc 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -23,7 +23,7 @@
 #ifdef CONFIG_PCI_DRIVERS_LEGACY
 
 /*
- * Each pci channel is a top-level PCI bus seem by CPU.	 A machine  with
+ * Each PCI channel is a top-level PCI bus seem by CPU.	 A machine with
  * multiple PCI channels may have multiple PCI host controllers or a
  * single controller supporting multiple channels.
  */
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 421e78c30253..088623ba7b8b 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -201,7 +201,7 @@ enum pgtable_bits {
  * The final layouts of the PTE bits are:
  *
  *   64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
- *   32-bit, R1 or earler:      CCC D V G M A W R P
+ *   32-bit, R1 or earlier:     CCC D V G M A W R P
  *   64-bit, R2 or later:       CCC D V G RI/R XI [S H] M A W P
  *   32-bit, R2 or later:       CCC D V G RI/R XI M A W P
  */
diff --git a/arch/mips/include/asm/sgi/mc.h b/arch/mips/include/asm/sgi/mc.h
index 3a070cec97e7..5e96f9d32624 100644
--- a/arch/mips/include/asm/sgi/mc.h
+++ b/arch/mips/include/asm/sgi/mc.h
@@ -96,7 +96,7 @@ struct sgimc_regs {
 	volatile u32 lbursttp;	/* Time period for long bursts */
 
 	/* MC chip can drive up to 4 bank 4 SIMMs each. All SIMMs in bank must
-	 * be the same size. The size encoding for supported SIMMs is bellow */
+	 * be the same size. The size encoding for supported SIMMs is below */
 	u32 _unused11[9];
 	volatile u32 mconfig0;	/* Memory config register zero */
 	u32 _unused12;
diff --git a/arch/mips/include/asm/sn/klconfig.h b/arch/mips/include/asm/sn/klconfig.h
index 117f85e4bef5..3d1670b3e052 100644
--- a/arch/mips/include/asm/sn/klconfig.h
+++ b/arch/mips/include/asm/sn/klconfig.h
@@ -851,7 +851,7 @@ typedef union kldev_s {	     /* for device structure allocation */
 /*
  * TBD - Allocation issues.
  *
- * Do we need to Mark off sepatate heaps for lboard_t, rboard_t, component,
+ * Do we need to Mark off separate heaps for lboard_t, rboard_t, component,
  * errinfo and allocate from them, or have a single heap and allocate all
  * structures from it. Debug is easier in the former method since we can
  * dump all similar structs in one command, but there will be lots of holes,
diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
index aabd097933fe..44c04a82d0b7 100644
--- a/arch/mips/include/asm/sync.h
+++ b/arch/mips/include/asm/sync.h
@@ -19,7 +19,7 @@
  *
  * Ordering barriers can be more efficient than completion barriers, since:
  *
- *   a) Ordering barriers only require memory access instructions which preceed
+ *   a) Ordering barriers only require memory access instructions which precede
  *      them in program order (older instructions) to reach a point in the
  *      load/store datapath beyond which reordering is not possible before
  *      allowing memory access instructions which follow them (younger
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index ecae7470faa4..b9d76e8ac5a2 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -27,7 +27,7 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
-	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptible, <0 => BUG */
 	struct pt_regs		*regs;
 	long			syscall;	/* syscall number */
 };
diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index 2e107886f97a..7ef06dcdc46e 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -46,7 +46,7 @@ typedef unsigned int cycles_t;
  *
  * There is a suggested workaround and also the erratum can't strike if
  * the compare interrupt isn't being used as the clock source device.
- * However for now the implementaton of this function doesn't get these
+ * However for now the implementation of this function doesn't get these
  * fine details right.
  */
 static inline int can_use_mips_counter(unsigned int prid)
diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/vdso.h
index a327ca21270e..6cd88191fefa 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -32,7 +32,7 @@ static inline unsigned long get_vdso_base(void)
 #else
 	/*
 	 * Get the base load address of the VDSO. We have to avoid generating
-	 * relocations and references to the GOT because ld.so does not peform
+	 * relocations and references to the GOT because ld.so does not perform
 	 * relocations on the VDSO. We use the current offset from the VDSO base
 	 * and perform a PC-relative branch which gives the absolute address in
 	 * ra, and take the difference. The assembler chokes on
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index c6e1fc77c996..9c48d9a21aa0 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -88,7 +88,7 @@
 #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
 #define MADV_NOHUGEPAGE 15		/* Not worth backing with hugepages */
 
-#define MADV_DONTDUMP	16		/* Explicity exclude from the core dump,
+#define MADV_DONTDUMP	16		/* Explicitly exclude from core dump,
 					   overrides the coredump filter bits */
 #define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
 
diff --git a/arch/mips/include/uapi/asm/msgbuf.h b/arch/mips/include/uapi/asm/msgbuf.h
index 128af72f2dfe..d546642fc67e 100644
--- a/arch/mips/include/uapi/asm/msgbuf.h
+++ b/arch/mips/include/uapi/asm/msgbuf.h
@@ -62,7 +62,7 @@ struct msqid64_ds {
 	unsigned long  __unused5;
 };
 #else
-#warning no endianess set
+#warning no endianness set
 #endif
 
 #endif /* _ASM_MSGBUF_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b406d8bfb15a..2f4fafdc5fcc 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1139,7 +1139,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		 * This processor doesn't have an MMU, so it's not
 		 * "real easy" to run Linux on it. It is left purely
 		 * for documentation.  Commented out because it shares
-		 * it's c0_prid id number with the TX3900.
+		 * its c0_prid id number with the TX3900.
 		 */
 		c->cputype = CPU_R4650;
 		__cpu_name[cpu] = "R4650";
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 316b27d0d2fb..dc39f5b3fb83 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -55,7 +55,7 @@ NOKPROBE_SYMBOL(insn_has_delayslot);
  * one; putting breakpoint on top of atomic ll/sc pair is bad idea;
  * so we need to prevent it and refuse kprobes insertion for such
  * instructions; cannot do much about breakpoint in the middle of
- * ll/sc pair; it is upto user to avoid those places
+ * ll/sc pair; it is up to user to avoid those places
  */
 static int insn_has_ll_or_sc(union mips_instruction insn)
 {
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 58fc8d089402..7eeeaf1ff95d 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -380,7 +380,7 @@ void *__init relocate_kernel(void)
 		}
 #endif /* CONFIG_USE_OF */
 
-		/* Copy the kernel to it's new location */
+		/* Copy the kernel to its new location */
 		memcpy(loc_new, &_text, kernel_length);
 
 		/* Perform relocations on the new kernel */
diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index 8f0a7263a9d6..de894a0211d7 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -70,7 +70,7 @@ copy_word:
 done:
 #ifdef CONFIG_SMP
 	/* kexec_flag reset is signal to other CPUs what kernel
-	   was moved to it's location. Note - we need relocated address
+	   was moved to its location. Note - we need relocated address
 	   of kexec_flag.  */
 
 	bal		1f
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2d2ca024bd47..f849667c2c57 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -146,7 +146,7 @@ static unsigned long __init init_initrd(void)
 	/*
 	 * Board specific code or command line parser should have
 	 * already set up initrd_start and initrd_end. In these cases
-	 * perfom sanity checks and use them if all looks good.
+	 * perform sanity checks and use them if all looks good.
 	 */
 	if (!initrd_start || initrd_end <= initrd_start)
 		goto disable;
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 479999b7f2de..a8e20fdc7afd 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -569,7 +569,7 @@ void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 		return (void __user __force *)(-1UL);
 
 	/*
-	 * FPU emulator may have it's own trampoline active just
+	 * FPU emulator may have its own trampoline active just
 	 * above the user stack, 16-bytes before the next lowest
 	 * 16 byte boundary.  Try to avoid trashing it.
 	 */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 246c6a6b0261..6aaa83834d07 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2418,7 +2418,7 @@ void __init trap_init(void)
 		set_except_vector(i, handle_reserved);
 
 	/*
-	 * Copy the EJTAG debug exception vector handler code to it's final
+	 * Copy the EJTAG debug exception vector handler code to its final
 	 * destination.
 	 */
 	if (cpu_has_ejtag && board_ejtag_handler_setup)
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index e9a0cfd02ae2..737d0d4fdcd3 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -6,9 +6,9 @@
  * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2013 Imagination Technologies Ltd.
  *
- * VPE spport module for loading a MIPS SP program into VPE1. The SP
+ * VPE support module for loading a MIPS SP program into VPE1. The SP
  * environment is rather simple since there are no TLBs. It needs
- * to be relocatable (or partiall linked). Initialize your stack in
+ * to be relocatable (or partially linked). Initialize your stack in
  * the startup-code. The loader looks for the symbol __start and sets
  * up the execution to resume from there. To load and run, simply do
  * a cat SP 'binary' to the /dev/vpe1 device.
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index e64372b8f66a..0feec52222fb 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -531,7 +531,7 @@ static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
  * to be used for a period of time, but the exact ktime corresponding to the
  * final Count that must be restored is not known.
  *
- * It is gauranteed that a timer interrupt immediately after restore will be
+ * It is guaranteed that a timer interrupt immediately after restore will be
  * handled, but not if CP0_Compare is exactly at @count. That case should
  * already be handled when the hardware timer state is saved.
  *
diff --git a/arch/mips/loongson2ef/common/platform.c b/arch/mips/loongson2ef/common/platform.c
index 0084820cffaa..b10300a527af 100644
--- a/arch/mips/loongson2ef/common/platform.c
+++ b/arch/mips/loongson2ef/common/platform.c
@@ -17,7 +17,7 @@ static int __init loongson2_cpufreq_init(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-	/* Only 2F revision and it's successors support CPUFreq */
+	/* Only 2F revision and its successors support CPUFreq */
 	if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON2F)
 		return platform_device_register(&loongson2_cpufreq_device);
 
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index e015a26a40f7..4f6c714430da 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -516,7 +516,7 @@ static void __init loongson3_prepare_cpus(unsigned int max_cpus)
 }
 
 /*
- * Setup the PC, SP, and GP of a secondary processor and start it runing!
+ * Setup the PC, SP, and GP of a secondary processor and start it running!
  */
 static int loongson3_boot_secondary(int cpu, struct task_struct *idle)
 {
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 187d1c16361c..20d37773b162 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1654,7 +1654,7 @@ static void coherency_setup(void)
 
 	/*
 	 * c0_status.cu=0 specifies that updates by the sc instruction use
-	 * the coherency mode specified by the TLB; 1 means cachable
+	 * the coherency mode specified by the TLB; 1 means cacheable
 	 * coherent update on write will be used.  Not all processors have
 	 * this bit and; some wire it to zero, others like Toshiba had the
 	 * silly idea of putting something else there ...
diff --git a/arch/mips/mm/cex-gen.S b/arch/mips/mm/cex-gen.S
index 45dff5cd4b8e..e528583d1331 100644
--- a/arch/mips/mm/cex-gen.S
+++ b/arch/mips/mm/cex-gen.S
@@ -25,7 +25,7 @@
 	 * This is a very bad place to be.  Our cache error
 	 * detection has triggered.  If we have write-back data
 	 * in the cache, we may not be able to recover.	 As a
-	 * first-order desperate measure, turn off KSEG0 cacheing.
+	 * first-order desperate measure, turn off KSEG0 caching.
 	 */
 	mfc0	k0,CP0_CONFIG
 	li	k1,~CONF_CM_CMASK
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 53dfa2b9316b..22a8f488ae1d 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -183,7 +183,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 	int idx, pid;
 
 	/*
-	 * Handle debugger faulting in for debugee.
+	 * Handle debugger faulting in for debuggee.
 	 */
 	if (current->active_mm != vma->vm_mm)
 		return;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 93c2d695588a..128a0a5ec2b7 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -301,7 +301,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	int idx, pid;
 
 	/*
-	 * Handle debugger faulting in for debugee.
+	 * Handle debugger faulting in for debuggee.
 	 */
 	if (current->active_mm != vma->vm_mm)
 		return;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b4e1c783e617..4017fa0e2f68 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -789,7 +789,7 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 	if (check_for_high_segbits) {
 		/*
-		 * The kernel currently implicitely assumes that the
+		 * The kernel currently implicitly assumes that the
 		 * MIPS SEGBITS parameter for the processor is
 		 * (PGDIR_SHIFT+PGDIR_BITS) or less, and will never
 		 * allocate virtual addresses outside the maximum
@@ -1715,7 +1715,7 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 /*
  * Check if PTE is present, if not then jump to LABEL. PTR points to
  * the page table where this PTE is located, PTE will be re-loaded
- * with it's original value.
+ * with its original value.
  */
 static void
 build_pte_present(u32 **p, struct uasm_reloc **r,
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index ace5db3fbd17..40a878b672f5 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -95,7 +95,7 @@
 /*
  * Mapping of 64-bit eBPF registers to 32-bit native MIPS registers.
  *
- * 1) Native register pairs are ordered according to CPU endiannes, following
+ * 1) Native register pairs are ordered according to CPU endianness, following
  *    the MIPS convention for passing 64-bit arguments and return values.
  * 2) The eBPF return value, arguments and callee-saved registers are mapped
  *    to their native MIPS equivalents.
diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
index 0d1b36ba1c21..068113f5c49d 100644
--- a/arch/mips/pci/ops-loongson2.c
+++ b/arch/mips/pci/ops-loongson2.c
@@ -49,7 +49,7 @@ static int loongson_pcibios_config_access(unsigned char access_type,
 		 */
 #ifdef CONFIG_CS5536
 		/* cs5536_pci_conf_read4/write4() will call _rdmsr/_wrmsr() to
-		 * access the regsters PCI_MSR_ADDR, PCI_MSR_DATA_LO,
+		 * access the registers PCI_MSR_ADDR, PCI_MSR_DATA_LO,
 		 * PCI_MSR_DATA_HI, which is bigger than PCI_MSR_CTRL, so, it
 		 * will not go this branch, but the others. so, no calling dead
 		 * loop here.
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 1c722dd0c130..58625d1b6465 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -453,7 +453,7 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 
 	/* we can't ioremap the entire pci config space because it's too large,
 	 * nor can we dynamically ioremap it because some drivers use the
-	 * PCI config routines from within atomic contex and that becomes a
+	 * PCI config routines from within atomic context and that becomes a
 	 * problem in get_vm_area().  Instead we use one wired TLB entry to
 	 * handle all config accesses for all busses.
 	 */
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index e17d862cfa4c..a925842ee125 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -16,7 +16,7 @@
  * the CFG_SEL bit in the PCI_MISC_CONFIG register.
  *
  * Devices on the bus can perform DMA requests via chip BAR1. PCI host
- * controller BARs are programmend as if an external device is programmed.
+ * controller BARs are programmed as if an external device is programmed.
  * Which means that during configuration, IDSEL pin of the chip should be
  * asserted.
  *
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 80f7293166bb..68a8cefed420 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -152,7 +152,7 @@ static int ltq_pci_startup(struct platform_device *pdev)
 		temp_buffer &= ~0xf0000;
 	/* enable internal arbiter */
 	temp_buffer |= (1 << INTERNAL_ARB_ENABLE_BIT);
-	/* enable internal PCI master reqest */
+	/* enable internal PCI master request */
 	temp_buffer &= (~(3 << PCI_MASTER0_REQ_MASK_2BITS));
 
 	/* enable EBU request */
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index d19d9d456309..36d12cea3512 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -376,7 +376,7 @@ static void octeon_pci_initialize(void)
 	ctl_status.s.timer = 1;
 	cvmx_write_csr(CVMX_NPI_CTL_STATUS, ctl_status.u64);
 
-	/* Deassert PCI reset and advertize PCX Host Mode Device Capability
+	/* Deassert PCI reset and advertise PCX Host Mode Device Capability
 	   (64b) */
 	cvmx_write_csr(CVMX_CIU_SOFT_PRST, 0x4);
 	cvmx_read_csr(CVMX_CIU_SOFT_PRST);
diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 68d5211afea8..45ddbaa6c123 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -114,7 +114,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
  *
  * The function is complicated by the ultimate brokenness of the IOC3 chip
  * which is used in SGI systems.  The IOC3 can only handle 32-bit PCI
- * accesses and does only decode parts of it's address space.
+ * accesses and does only decode parts of its address space.
  */
 static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 				 int where, int size, u32 *value)
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index c9edd3fb380d..2583e318e8c6 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1037,7 +1037,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
 			in_fif_p_count = dbg_data.s.data & 0xff;
 		} while (in_fif_p_count != ((old_in_fif_p_count+1) & 0xff));
 
-		/* Update in_fif_p_count for it's offset with respect to out_p_count */
+		/* Update in_fif_p_count for its offset with respect to out_p_count */
 		in_fif_p_count = (in_fif_p_count + in_p_offset) & 0xff;
 
 		/* Read the OUT_P_COUNT from the debug select */
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 137781d0bd0a..5a9fd3fe41d7 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -175,7 +175,7 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 		 * mips_cm_probe() wipes out bootloader
 		 * config for CM regions and we have to configure them
 		 * again. This SoC cannot talk to pamlbus devices
-		 * witout proper iocu region set up.
+		 * without proper iocu region set up.
 		 *
 		 * FIXME: it would be better to do this with values
 		 * from DT, but we need this very early because
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 5ae30b78d38d..d9249f5a632e 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -348,7 +348,7 @@ static void final_fixup(struct pci_dev *dev)
 	unsigned char bist;
 	int ret;
 
-	/* Do build-in self test */
+	/* Do built-in self test */
 	ret = pci_read_config_byte(dev, PCI_BIST, &bist);
 	if ((ret != PCIBIOS_SUCCESSFUL) || !(bist & PCI_BIST_CAPABLE))
 		return;
-- 
2.34.1


