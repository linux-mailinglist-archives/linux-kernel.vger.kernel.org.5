Return-Path: <linux-kernel+bounces-166272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC08B9857
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18321F254A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376E6BB47;
	Thu,  2 May 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="H3coU0em";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEsaEytb"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A95FBAA;
	Thu,  2 May 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643988; cv=none; b=hKhZt+SaxRFGdWE4VU2H+NHWX9KbrsTdmbDCUFS3JfS8A9fFqcS/NMC+IwyA9zAxfiyGeLZuZmPXcs7oc6ykpfVMMqn0opw/pcuZAuowrUUqGqLY175ieuTL3+0LOOzfx8TNWIYNpMusYg7O4j7c1Gmc4dCAX+/S9r9LkOOwUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643988; c=relaxed/simple;
	bh=rHXlSGuBuAGOebwT6ljnZUR4A2ggQDC/gzRZSSvOH8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvTULKMwD/MLv+5YFBjUHgTURFzYBemp/1WkXICZJnhiI2bf7pNXPJ5EOMV16IWh1QF3BsUSPqx/TkT429Qo//yRuJNE99vO42ZKwc7sRhGdmTGyYaq44nn1hr+HcJJnPzvb63j+18pYRiWZATn5TtPplkdUuceD/bpwITnvT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=H3coU0em; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEsaEytb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6386F13810C2;
	Thu,  2 May 2024 05:59:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 May 2024 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714643985;
	 x=1714730385; bh=J5USqJfzmDpY6z7Mk5I1sDGwgWVH9RZKC0Qm4bqHxoQ=; b=
	H3coU0emgu2qHj2efcAnvdn/AOPOawZbYw4t03J9STLF6w4dxdEgGTJo1vz60ofH
	9WkkgLsCO6oRkdvdVpvveVl7JGNmpMvPkkE6z8HRj7cCg4WsETQ8YvYBlmYM6FLA
	jGxhYxYZQtMPta0vsNQsOWPzZDtUC7/dn5D7K5YdP198FMP6/qH+GUpjiYdwND35
	P884A4ieWCigp6BDs3DzV8rciMebzhXDCiyC2bpOZkt0TiCJsPmFYAeRGp6ZOx+M
	BvxMv6UC0ZZd+jdY84rnh8x/mLyxjmXgLYJau1WCqSu2qhxuBJ9xlj+cqpJwjiDu
	ET1Xw0jLM2Pp2RNXuhrKjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714643985; x=
	1714730385; bh=J5USqJfzmDpY6z7Mk5I1sDGwgWVH9RZKC0Qm4bqHxoQ=; b=G
	EsaEytbvEerhE68ail2ERZLCbme66NXyCx+u9FwPlrrkbkmlw6N4vxNJWBcJ1FiN
	o0XrwZb1CkEl8Gvmg4BGjZOK2HII9xyDB8ILH7Ck4ASnBBs06k2pG4VKLO+X60iC
	Q5oJQJHGlbvXgT/TN8oXsVDYreaMkqMhGJCWg/PBgSqLlFsQo0RIsPcWju5FrpgH
	0MA9qn0mLY4G9ImRBo9FQU1QXYp/lNz7IiwpWtYR70SHTceDwtY5PVtIfxUio85f
	e0h2FNFgyPTS2LZvmeFRyk7ah1OYV/7MzctEhQIkTaeW2iTwAHJJc5xC83Btmad4
	G6yPQ4VjzuVgncnlNuv0w==
X-ME-Sender: <xms:EGQzZqg3uTIv0uiYSUBOTVfmYTfOQyMMCVBnWqofutSbEyWDYhKP0w>
    <xme:EGQzZrC-s0eilfORRi3um7g1kNv6Jx6sIGILSHT6poFdITO-2mqckQJ3XAugO4qzE
    YjeMVAGHcw0BaQtbjk>
X-ME-Received: <xmr:EGQzZiGpemZiHMBVhG7TQeRL1Hwh2rtLQUymd3dPIoyWquDYp57gIZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepfffhgeffffejvedvuedvveehhfejgeeiheegfedvffehffej
    gffggfetteelieffnecuffhomhgrihhnpeguvggsuhhgqdhvvggtrdhssgdpuggvsghugh
    drshgspdhhvggrugdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:EWQzZjQVfaMi-vSgnzX9gi_nszavsOD8UKTagq8fCD3BKRopTCn2SA>
    <xmx:EWQzZnyDgt2fNF40_-AETvmdUcF9hSQ3OBSZP9T012pi-F2dMADHXw>
    <xmx:EWQzZh4A6tFDBj3tM9Kiq6ATHNALmW5qjGJUE-iTYg7ZbngBxwiMeQ>
    <xmx:EWQzZkySAi8r5htrb0rA9WVLji19N_BJi52HwL_cAEx386NbgxbfUA>
    <xmx:EWQzZirAIulPzjcnwA2Yz6alrbMShT1E0tCwJ53d8Q1HzMfM-8X5lA1v>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:44 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 May 2024 10:59:35 +0100
Subject: [PATCH v3 8/9] MIPS: zboot: Convert to use debug_ll facilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240502-mips_debug_ll-v3-8-3b61f30e484c@flygoat.com>
References: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
In-Reply-To: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10586;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=rHXlSGuBuAGOebwT6ljnZUR4A2ggQDC/gzRZSSvOH8k=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFPbasOl7vvcfEXuySFHO/u5Rx/+rCpy9hQTfHOmYM
 Smp2+l5RykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkQx7DT8Ynwq4PlW+fZXrh
 z6q+801qzhLVK5EKy78kBG36uWRfyQ5Gho0OLydsYtoSZt5w4fvau1usr1ucvhx92y5F1Nkjsfd
 oJBsA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Since now debug_ll facilities can cover all platforms supported
by zboot debug print, and it provides extra capability on debugging
exceptions, switch zboot to use those facilities.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                        | 12 ++------
 arch/mips/Kconfig.debug                  | 46 +++++++++++++-----------------
 arch/mips/boot/compressed/Makefile       |  9 ++----
 arch/mips/boot/compressed/dbg.c          | 39 -------------------------
 arch/mips/boot/compressed/debug-vec.S    |  3 ++
 arch/mips/boot/compressed/debug.S        |  3 ++
 arch/mips/boot/compressed/decompress.h   |  8 +++---
 arch/mips/boot/compressed/head.S         |  6 ++++
 arch/mips/boot/compressed/uart-16550.c   | 49 --------------------------------
 arch/mips/boot/compressed/uart-alchemy.c |  9 ------
 arch/mips/boot/compressed/uart-ath79.c   |  2 --
 arch/mips/boot/compressed/uart-prom.c    |  9 ------
 12 files changed, 39 insertions(+), 156 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 06ef440d16ce..6729bf1d158d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -240,7 +240,7 @@ config ATH79
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
-	select SYS_SUPPORTS_ZBOOT_UART_PROM
+	select SYS_SUPPORTS_ZBOOT
 	select USE_OF
 	select USB_EHCI_ROOT_HUB_TT if USB_EHCI_HCD_PLATFORM
 	help
@@ -422,7 +422,7 @@ config MACH_INGENIC_SOC
 	select MIPS_GENERIC
 	select MACH_INGENIC
 	select MACH_GENERIC_CORE
-	select SYS_SUPPORTS_ZBOOT_UART16550
+	select SYS_SUPPORTS_ZBOOT
 	select CPU_SUPPORTS_CPUFREQ
 	select MIPS_EXTERNAL_TIMER
 
@@ -1792,14 +1792,6 @@ config SYS_SUPPORTS_ZBOOT
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
 
-config SYS_SUPPORTS_ZBOOT_UART16550
-	bool
-	select SYS_SUPPORTS_ZBOOT
-
-config SYS_SUPPORTS_ZBOOT_UART_PROM
-	bool
-	select SYS_SUPPORTS_ZBOOT
-
 config CPU_LOONGSON2EF
 	bool
 	select CPU_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index a6687c503c34..0ce6d24d05b3 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -79,33 +79,6 @@ config SB1XXX_CORELIS
 	  Select compile flags that produce code that can be processed by the
 	  Corelis mksym utility and UDB Emulator.
 
-config DEBUG_ZBOOT
-	bool "Enable compressed kernel support debugging"
-	depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT
-	default n
-	help
-	  If you want to add compressed kernel support to a new board, and the
-	  board supports uart16550 compatible serial port, please select
-	  SYS_SUPPORTS_ZBOOT_UART16550 for your board and enable this option to
-	  debug it.
-
-	  If your board doesn't support uart16550 compatible serial port, you
-	  can try to select SYS_SUPPORTS_ZBOOT and use the other methods to
-	  debug it. for example, add a new serial port support just as
-	  arch/mips/boot/compressed/uart-16550.c does.
-
-	  After the compressed kernel support works, please disable this option
-	  to reduce the kernel image size and speed up the booting procedure a
-	  little.
-
-config ZBOOT_INGENIC_UART
-	int "UART to use for compressed kernel debugging"
-	depends on DEBUG_ZBOOT && MACH_INGENIC_SOC
-	default 0
-	range 0 4
-	help
-	  Specify the UART that should be used for compressed kernel debugging.
-
 config SPINLOCK_TEST
 	bool "Enable spinlock timing tests in debugfs"
 	depends on DEBUG_FS
@@ -328,3 +301,22 @@ config DEBUG_UART_8250_WIDTH
 	int "Register width for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default 1
+
+config DEBUG_ZBOOT
+	bool "Enable compressed kernel debugging via DEBUG_LL output"
+	depends on DEBUG_LL && SYS_SUPPORTS_ZBOOT
+	help
+	  Say Y here if you want to enable debugging of a compressed kernel
+	  via the DEBUG_LL output.  This is useful if you are debugging
+	  decompressor issues.
+
+	  If unsure, say N.
+
+config DEBUG_ZBOOT_EXCEPT
+	bool "Enable compressed kernel debugging of exceptions"
+	depends on DEBUG_ZBOOT
+	help
+	  Say Y here if you want to enable debugging of exceptions happen
+	  during decompression of a compressed kernel via the DEBUG_LL output.
+
+	  If unsure, say N.
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 6cc28173bee8..78c65db8dd04 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -43,13 +43,8 @@ KCSAN_SANITIZE			:= n
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o
 
-ifdef CONFIG_DEBUG_ZBOOT
-vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		   += $(obj)/dbg.o
-vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
-vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
-vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
-vmlinuzobjs-$(CONFIG_ATH79)			   += $(obj)/uart-ath79.o
-endif
+vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		+= $(obj)/debug.o
+vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT_EXCEPT)	+= $(obj)/debug-vec.o
 
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o
 
diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
deleted file mode 100644
index 95405292accd..000000000000
--- a/arch/mips/boot/compressed/dbg.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * MIPS-specific debug support for pre-boot environment
- *
- * NOTE: putc() is board specific, if your board have a 16550 compatible uart,
- * please select SYS_SUPPORTS_ZBOOT_UART16550 for your machine. otherwise, you
- * need to implement your own putc().
- */
-#include <linux/compiler.h>
-#include <linux/types.h>
-
-#include "decompress.h"
-
-void __weak putc(char c)
-{
-}
-
-void puts(const char *s)
-{
-	char c;
-	while ((c = *s++) != '\0') {
-		putc(c);
-		if (c == '\n')
-			putc('\r');
-	}
-}
-
-void puthex(unsigned long long val)
-{
-
-	unsigned char buf[10];
-	int i;
-	for (i = 7; i >= 0; i--) {
-		buf[i] = "0123456789ABCDEF"[val & 0x0F];
-		val >>= 4;
-	}
-	buf[8] = '\0';
-	puts(buf);
-}
diff --git a/arch/mips/boot/compressed/debug-vec.S b/arch/mips/boot/compressed/debug-vec.S
new file mode 100644
index 000000000000..e7bedb183da8
--- /dev/null
+++ b/arch/mips/boot/compressed/debug-vec.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/debug-vec.S"
diff --git a/arch/mips/boot/compressed/debug.S b/arch/mips/boot/compressed/debug.S
new file mode 100644
index 000000000000..0cf3da958f7e
--- /dev/null
+++ b/arch/mips/boot/compressed/debug.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/debug.S"
diff --git a/arch/mips/boot/compressed/decompress.h b/arch/mips/boot/compressed/decompress.h
index 073b64593b3d..e375d50c71a0 100644
--- a/arch/mips/boot/compressed/decompress.h
+++ b/arch/mips/boot/compressed/decompress.h
@@ -7,11 +7,11 @@ extern unsigned char __image_begin[], __image_end[];
 
 /* debug interfaces  */
 #ifdef CONFIG_DEBUG_ZBOOT
-extern void putc(char c);
-extern void puts(const char *s);
-extern void puthex(unsigned long long val);
+extern void printascii(const char *s);
+extern void printhexl(unsigned long val);
+#define puts(s) printascii(s)
+#define puthex(val) printhexl(val)
 #else
-#define putc(s) do {} while (0)
 #define puts(s) do {} while (0)
 #define puthex(val) do {} while (0)
 #endif
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index d237a834b85e..b05e9591d3af 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -22,6 +22,12 @@
 	move	s2, a2
 	move	s3, a3
 
+#ifdef CONFIG_DEBUG_ZBOOT_EXCEP
+	/* Set up the exception vector */
+	PTR_LA	t9, setup_debug_ll_exception
+	jalr	t9
+#endif
+
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
deleted file mode 100644
index db618e72a0c4..000000000000
--- a/arch/mips/boot/compressed/uart-16550.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * 16550 compatible uart based serial debug support for zboot
- */
-
-#include <linux/types.h>
-#include <linux/serial_reg.h>
-
-#include <asm/addrspace.h>
-
-#include "decompress.h"
-
-#if defined(CONFIG_MACH_LOONGSON64) || defined(CONFIG_MIPS_MALTA)
-#define UART_BASE 0x1fd003f8
-#define PORT(offset) (CKSEG1ADDR(UART_BASE) + (offset))
-#endif
-
-#ifdef CONFIG_MACH_INGENIC
-#define INGENIC_UART_BASE_ADDR	(0x10030000 + 0x1000 * CONFIG_ZBOOT_INGENIC_UART)
-#define PORT(offset) (CKSEG1ADDR(INGENIC_UART_BASE_ADDR) + (4 * offset))
-#endif
-
-#ifndef IOTYPE
-#define IOTYPE char
-#endif
-
-#ifndef PORT
-#error please define the serial port address for your own machine
-#endif
-
-static inline unsigned int serial_in(int offset)
-{
-	return *((volatile IOTYPE *)PORT(offset)) & 0xFF;
-}
-
-static inline void serial_out(int offset, int value)
-{
-	*((volatile IOTYPE *)PORT(offset)) = value & 0xFF;
-}
-
-void putc(char c)
-{
-	int timeout = 1000000;
-
-	while (((serial_in(UART_LSR) & UART_LSR_THRE) == 0) && (timeout-- > 0))
-		;
-
-	serial_out(UART_TX, c);
-}
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
deleted file mode 100644
index 003967c084b3..000000000000
--- a/arch/mips/boot/compressed/uart-alchemy.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/mach-au1x00/au1000.h>
-
-#include "decompress.h"
-
-void putc(char c)
-{
-	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
-}
diff --git a/arch/mips/boot/compressed/uart-ath79.c b/arch/mips/boot/compressed/uart-ath79.c
deleted file mode 100644
index d686820921be..000000000000
--- a/arch/mips/boot/compressed/uart-ath79.c
+++ /dev/null
@@ -1,2 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include "../../ath79/early_printk.c"
diff --git a/arch/mips/boot/compressed/uart-prom.c b/arch/mips/boot/compressed/uart-prom.c
deleted file mode 100644
index 5fa3b9945333..000000000000
--- a/arch/mips/boot/compressed/uart-prom.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/setup.h>
-
-#include "decompress.h"
-
-void putc(char c)
-{
-	prom_putchar(c);
-}

-- 
2.34.1


