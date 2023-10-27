Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016F47DA0BE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjJ0SmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346393AbjJ0Slz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:41:55 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8D555AA;
        Fri, 27 Oct 2023 11:30:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 063313200A1C;
        Fri, 27 Oct 2023 14:27:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 14:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698431238; x=
        1698517638; bh=yIBHHJoeBZonb5tndpSrM+X2Yc5Shk4jUNpLuZRp3To=; b=M
        M3wd7zqrJC5qXl9sTmLvySfmGQgaon1ZtJSJykSv1wYpkQeCN3718Pl4AU4lW1Tb
        CoGyagVsVe4ralBcTx4pqHDePWZtxT6WollHVWZeieaOsq7/aozUdSdTgiGyg5vF
        ptRoMVkp+dOSnUtkoCiRqycWuuKlakRxVRtFQbLzmwnPwZQfPjBiUx1h4rZy2a29
        GPrgorQE7sl3fJjOtzPifcHYAx01YzY5vV8oSjvZq8MYKDFXYNB95Lrr53cxvChM
        RueITPoH/FAm1z8aCaWRr94DZyINNSwbwvgli+QN31wjU4LA5k+GRd0UIX27myS6
        JYDQbG8fWbsOBf68kc1Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698431238; x=
        1698517638; bh=yIBHHJoeBZonb5tndpSrM+X2Yc5Shk4jUNpLuZRp3To=; b=l
        2sWnMmC28aBM+5g5OlaoLLhCE03Bvf2w5T/NFjg1thPC5zFMxB8l/cMqIznFlPyZ
        /7afcKESaqeoCrfGtz2cXA2NpLbY7Rvb50JD6JcDTAAIWIB6Q0LtNkkxbsJ0iMFY
        mc1SX+AqRtxn8bQJn/IKqmRTBHRbDJTRmD1ngHnNaXOniMYuIdurq5gaNfYmyuNC
        T416LAGmdkLMP8rxcj4EEybqgFsockgWHp2mZ7Xrh/5OsSukKgZz9j8ww4Tc9gFP
        GZvx8oWIbomZlXTkpn/ZMAN3VezZCaYLE7AGZumJH/PID5gSPcn+qDiqfG7L8njD
        VFWOCHHGstPXiMyW/BjVA==
X-ME-Sender: <xms:BgE8ZYvmAFRy4c41V-eaa3DjqU4RTXMeW6lFwErtorVhP4sdf1cTjg>
    <xme:BgE8ZVcnne1IzF0B1rP7jFmkLJ5fkNIW2lmOeRdJHdNPuYq-3VN8wZkAQJKOzjwSy
    fML8RtFHkw7XOpDZ70>
X-ME-Received: <xmr:BgE8ZTxC1gpmCcjSv2FG6O3EkMflBa6Tcd0lbIad630AhoplNcQ37cbQwB2WJ-3aaNcamyoSiws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:BgE8ZbOH73hgi9oEk0A-z-NDPO0ZFAz4daj07RQRPza6PXqRcXiP_w>
    <xmx:BgE8ZY9dL0F1970LoWRf3Ok-KHyseZ8oMZafcuwe-kodI1-Is2GenQ>
    <xmx:BgE8ZTXs8xHw9NDHZTPdobs2F2S2uxP3KkyqvWajB8XR_fz-Ll9QnQ>
    <xmx:BgE8ZXna2ZSbEjp1xLuZRt6zXenRR1eIPE6L3zt9VVXa1RZC6VkW8Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:27:17 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] serial: Add an earlycon driver for MIPS UHI semihosting
Date:   Fri, 27 Oct 2023 19:26:50 +0100
Message-Id: <20231027182650.281405-8-jiaxun.yang@flygoat.com>
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

UHI is MIPS's implementation of semihosting.
Add an earlycon driver to help with debugging on boot.

This driver is capable for print log using UHI's "Plog" or interact
with KGDB using UHI's stdio function.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/tty/serial/Kconfig             | 13 ++++
 drivers/tty/serial/Makefile            |  1 +
 drivers/tty/serial/earlycon-mips-uhi.c | 85 ++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/tty/serial/earlycon-mips-uhi.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bdc568a4ab66..04c62c6b45cd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -85,6 +85,19 @@ config SERIAL_EARLYCON_SEMIHOST
 	  This is enabled with "earlycon=smh" on the kernel command line.
 	  The console is enabled when early_param is processed.
 
+config SERIAL_EARLYCON_UHI
+	bool "Early console using MIPS UHI semihosting"
+	depends on MIPS
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Support for early debug console using UHI semihosting.
+	  This enables the console before standard serial driver is probed.
+	  This is enabled with "earlycon=uhi" or "earlycon=uhi_stdio" on the
+	  kernel command line.
+	  The console is enabled when early_param is processed.
+
 config SERIAL_EARLYCON_RISCV_SBI
 	bool "Early console using RISC-V SBI"
 	depends on RISCV_SBI_V01
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index f6b8c220dcfb..ef5e9c87aea1 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -9,6 +9,7 @@ serial_base-y := serial_core.o serial_base_bus.o serial_ctrl.o serial_port.o
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) += earlycon-semihost.o
 obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) += earlycon-riscv-sbi.o
+obj-$(CONFIG_SERIAL_EARLYCON_MIPS_UHI) += earlycon-mips-uhi.o
 
 # These Sparc drivers have to appear before others such as 8250
 # which share ttySx minor node space.  Otherwise console device
diff --git a/drivers/tty/serial/earlycon-mips-uhi.c b/drivers/tty/serial/earlycon-mips-uhi.c
new file mode 100644
index 000000000000..002bb2c37064
--- /dev/null
+++ b/drivers/tty/serial/earlycon-mips-uhi.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MIPS UHI semihosting based earlycon
+ *
+ * Copyright (C) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <asm/uhi.h>
+
+static int stdin_fd = -1;
+static int stdout_fd = -1;
+
+static void uhi_plog_write(struct console *con, const char *s, unsigned int n)
+{
+	uhi_plog(s, 0);
+}
+
+static void uhi_stdout_write(struct console *con, const char *s, unsigned int n)
+{
+	if (stdout_fd < 0)
+		return;
+
+	uhi_write(stdout_fd, s, n);
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int uhi_stdin_read(struct console *con, char *s, unsigned int n)
+{
+	if (stdin_fd < 0)
+		return 0;
+
+	return uhi_read(stdin_fd, s, n);
+}
+#endif
+
+static int uhi_stdio_fd_open(struct console *co, char *options)
+{
+	/*
+	 * You have to open both stdin and stdout to get console work
+	 * properly on some old CodeScape debugger.
+	 */
+	stdin_fd = uhi_open("/dev/stdin", UHI_O_RDONLY, 0);
+	stdout_fd = uhi_open("/dev/stdout", UHI_O_WRONLY, 0);
+
+	return (stdin_fd < 0 || stdout_fd < 0) ? -ENODEV : 0;
+}
+
+static int uhi_stdio_fd_close(struct console *co)
+{
+	int ret1 = 0, ret2 = 0;
+
+	if (stdin_fd >= 0)
+		ret1 = uhi_close(stdin_fd);
+	if (stdout_fd >= 0)
+		ret2 = uhi_close(stdout_fd);
+
+	return (ret1 < 0 || ret2 < 0) ? -ENODEV : 0;
+}
+
+static int
+__init early_uhi_setup(struct earlycon_device *device, const char *opt)
+{
+	device->con->write = uhi_plog_write;
+	return 0;
+}
+
+static int
+__init early_uhi_stdio_setup(struct earlycon_device *device, const char *opt)
+{
+
+	device->con->setup = uhi_stdio_fd_open;
+	device->con->exit = uhi_stdio_fd_close;
+	device->con->write = uhi_stdout_write;
+#ifdef CONFIG_CONSOLE_POLL
+	device->con->read = uhi_stdin_read;
+#endif
+	return 0;
+}
+
+EARLYCON_DECLARE(uhi, early_uhi_setup);
+EARLYCON_DECLARE(uhi_stdio, early_uhi_stdio_setup);
-- 
2.34.1

