Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E17DA06E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjJ0Sal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjJ0Sab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:30:31 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4B47AC;
        Fri, 27 Oct 2023 11:29:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E047C3200928;
        Fri, 27 Oct 2023 14:27:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 14:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698431224; x=
        1698517624; bh=DsEFHXOmV/vlMNorRiSfNz2hmb8DBQjO66z36QC0Uz4=; b=c
        DaSv6h34dyBQZGk4Q+R3dbVsKnW++9bGUVJ3l53Wu5LT3cW4gcV5DiRw5ia9zDnD
        r5nRbcsFpOSihlrtbp+Q4fDgsD+vhS2NkrLUIGw4KHlxOEL8yLObz0g8LZ3XOgtM
        8aHjXrqb96quA4MLXTJO5cWdEYkYFxq0O/GNtQpVhbnl6f6+6e2vpeAaWPdhsvVD
        v9mfkv8QSiIqBC7sonZHwc8DrKXK3b48w9EmVNre7azIQfRkKUbCkaUD07aJVRnq
        2jOxjiYh+gWkGoT+mvqx0VnSOdQTj+vCUdPGIgK0TteJinFcQ5Jy7zPkU5NFPUmW
        KLTPDkkU5E1rizYoMbLhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698431224; x=
        1698517624; bh=DsEFHXOmV/vlMNorRiSfNz2hmb8DBQjO66z36QC0Uz4=; b=f
        /pDHJyBrHQhfKMoGWAE209vCCOy6IGMd7jbSc/HYt1N8E9itRb8z5paNtGxRA++0
        Rmict7v2r2JSO/r55Iyn6GAUMY2NXsP1u81924Xi5M66Qo/AeQ3RIFG04mVAlkMy
        l3z2DWPioiVI2Mpmw9BjdIAndSIjsojv63zkCkQldAkQbW5DvofNJbqEndN5VyFf
        vjC0aeMAhaFngekVUPv1LehYzChkqFZTTjBGGgSo1lbWGC4s9rHsESR5CM8OovQ5
        1XTQ9ZdHJgOMKbkG/Fw1GmV3Hqu+GjTowRJtBy0Akxv7yBI5IaSI/gVZcWPwYCda
        z7oOPDWM6BdgoI+EqEv9Q==
X-ME-Sender: <xms:-AA8ZevXVeQrnM3zOBUaKVd9qg0M9K4RI0-9zjgiNVlvgDHMAo6GdA>
    <xme:-AA8ZTctJHfJdsjV3WVJR3h9AREaL0RoNrl7-8tcCj0SaN44Eu2cVMCnyITphdRpq
    6mEKiAXdRvM0K3I3cA>
X-ME-Received: <xmr:-AA8ZZwCG5Os7Be6T3Xy6cxgt5AaWLOaa-sDkm5P_yu9oUsEN7sLbFOxjINg76Xg2svx4T3qT8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:-AA8ZZOwi9vxGRSmmvngRXe5AGvXSEdhTjUkjj88Ji3zQPt7lDXvVA>
    <xmx:-AA8Ze8E5niN_FTd__aJ5yOz-Q_TCUmE2FpPOu3s8r4DqBnX3psR6A>
    <xmx:-AA8ZRVwmXHCZYd_17ukcI5NbZcfk9si9tqIrKbPtp25y-0tWPnecg>
    <xmx:-AA8ZVmt80Z3BH6G9Tyrlqp54JKKyd0MlQWuoU8Yad-SZp6ZROm__A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:27:03 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] MIPS: zboot: Add UHI semihosting debug print support
Date:   Fri, 27 Oct 2023 19:26:45 +0100
Message-Id: <20231027182650.281405-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
References: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support print debug message via MIPS UHI semihosting Plog
functions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug                | 11 +++++++++++
 arch/mips/boot/compressed/Makefile     |  1 +
 arch/mips/boot/compressed/dbg-uhi.c    | 11 +++++++++++
 arch/mips/boot/compressed/dbg.c        |  4 ++--
 arch/mips/boot/compressed/decompress.c |  4 ++++
 5 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/boot/compressed/dbg-uhi.c

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index f4ae7900fcd3..1393bdb33f5c 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -98,6 +98,17 @@ config DEBUG_ZBOOT
 	  to reduce the kernel image size and speed up the booting procedure a
 	  little.
 
+config ZBOOT_DBG_UHI
+	bool "Enable UHI debugging"
+	depends on DEBUG_ZBOOT
+	default n
+	help
+	  Enable this option to debug compressed kernel support via UHI.
+	  Logs will be outputed to the host machine via UHI Plog function.
+	  You MUST connect system to a debugger with UHI semihosting support
+	  or use a boot montor implemented UHI exceptions, otherwise the
+	  system will hang.
+
 config ZBOOT_INGENIC_UART
 	int "UART to use for compressed kernel debugging"
 	depends on DEBUG_ZBOOT && MACH_INGENIC_SOC
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 6cc28173bee8..5667597c3584 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -45,6 +45,7 @@ vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswaps
 
 ifdef CONFIG_DEBUG_ZBOOT
 vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		   += $(obj)/dbg.o
+vmlinuzobjs-$(CONFIG_ZBOOT_DBG_UHI)		   += $(obj)/dbg-uhi.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
diff --git a/arch/mips/boot/compressed/dbg-uhi.c b/arch/mips/boot/compressed/dbg-uhi.c
new file mode 100644
index 000000000000..7daa8de717b0
--- /dev/null
+++ b/arch/mips/boot/compressed/dbg-uhi.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * zboot debug output for MIPS UHI semihosting
+ */
+
+#include <asm/uhi.h>
+
+void puts(const char *s)
+{
+	uhi_plog(s, 0);
+}
diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
index f6728a8fd1c3..7fa5242e2b7d 100644
--- a/arch/mips/boot/compressed/dbg.c
+++ b/arch/mips/boot/compressed/dbg.c
@@ -4,7 +4,7 @@
  *
  * NOTE: putc() is board specific, if your board have a 16550 compatible uart,
  * please select SYS_SUPPORTS_ZBOOT_UART16550 for your machine. othewise, you
- * need to implement your own putc().
+ * need to implement your own putc() or puts().
  */
 #include <linux/compiler.h>
 #include <linux/types.h>
@@ -13,7 +13,7 @@ void __weak putc(char c)
 {
 }
 
-void puts(const char *s)
+void __weak puts(const char *s)
 {
 	char c;
 	while ((c = *s++) != '\0') {
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index c5dd415254d3..f4e69dfe2923 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -17,6 +17,7 @@
 
 #include <asm/addrspace.h>
 #include <asm/unaligned.h>
+#include <asm/uhi.h>
 #include <asm-generic/vmlinux.lds.h>
 
 /*
@@ -46,6 +47,9 @@ void error(char *x)
 	puts(x);
 	puts("\n\n -- System halted");
 
+#ifdef CONFIG_ZBOOT_DBG_UHI
+	uhi_bootfailure(0);
+#endif
 	while (1)
 		;	/* Halt */
 }
-- 
2.34.1

