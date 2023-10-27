Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0A7DA0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbjJ0SmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjJ0Sls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:41:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87843C30;
        Fri, 27 Oct 2023 11:29:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A98093200A19;
        Fri, 27 Oct 2023 14:27:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 14:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698431227; x=
        1698517627; bh=yIBHHJoeBZonb5tndpSrM+X2Yc5Shk4jUNpLuZRp3To=; b=n
        aUfD8yEGmPxYxKacatPB3aokAcd/AHtxWtRn1xZnTh5e/5RDVCjSlw8ynDpaXER/
        f0ja4+MPIolnmtCwb1MZQi+cbpehap6itUwhMYMqaLAtKjkvHOxSKg3c3dlzXvPy
        PghO6Ko0s7gpSvzichGNLyBv2aGvqNL84zEuADPBf7sVnYBoQxkk5ZBMVAhIuKF3
        MteufCcnpGzydQEpct2+cuubjxfLBI2i0vtd78m8XAjqliF1Z7EIWyHbc/QucT3v
        VuX7xuZ6vmNnsyR36arpSH7LN/ObhMpNL+tPRl5zrUCVySt8PIfCNeSqHSiVbQI3
        /xMxZvSxwfGWPUpItLM4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698431227; x=
        1698517627; bh=yIBHHJoeBZonb5tndpSrM+X2Yc5Shk4jUNpLuZRp3To=; b=V
        Ly4xBC6UZz6S/C6L8cTheRblnlcx0MvsV0hA8rrS3Mhu5FFtMoBxjS3GELvF3Q3I
        /4M05QUTC9ygq66jB7zkjJEFiJodXBMlyVa2LnTissAPxH6J291LXSCLveQZkGpG
        TMF0J6pMGSePeAbVksg4Vysy4bJGw4r2mKANmX41lg2wzYgen8ZvJZNvudojd03+
        AZB61cfwF3IJvi+f57HCUVHuszjE4R4nrtgoeWCaFG6TGnLDj//LLP5MweuWUdTQ
        OuYhgw/xomF3dOFqMyTDuLc2D4fpxfT+00R3JtTvanAEz9rBmnxaRfp/57GZqzDE
        MZSvb7BhdJqyBH9NjZKgw==
X-ME-Sender: <xms:-gA8ZdpBUTCppmZZqxevIRFRxWNd14tlWZHqpNoNMOCRVt9sgHAVlA>
    <xme:-gA8ZfoBsZzY9PnyZRgw_cX8-0pYnEl3ECZqoEbP6lCsaSxRhEf_ztMg85MDMm4bD
    QYi0GtJkuVruK6aPuc>
X-ME-Received: <xmr:-gA8ZaPL_FQrhuqXhTEIoYhi3tMB8hk2Pxb1J4T_SogHa_fD6WQkt3xo8ktXcsgeLsaQLWttbIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:-wA8ZY6SvqfNxlHgqCYpP2YQ6BW2aYNRPQ2BRUZFpV8uNFHapB1_4w>
    <xmx:-wA8Zc6--x7ouRpE9-uTiwNmk9HhS2TEZzi0mJwuwD8qTLf4JvWDzA>
    <xmx:-wA8ZQjua2ml0OMBdnCKj1DgTdzvcpZwsUdNcbm4MW-HtsZwr17h6g>
    <xmx:-wA8ZWTeNAv6mFgVUFzhfu5Oq6YIFpHRhHz5ugRqKC2PI2oDSGI9Bg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:27:05 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] serial: Add an earlycon driver for MIPS UHI semihosting
Date:   Fri, 27 Oct 2023 19:26:46 +0100
Message-Id: <20231027182650.281405-4-jiaxun.yang@flygoat.com>
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

