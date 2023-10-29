Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E937DACA8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjJ2NqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjJ2NqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:46:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C84C5;
        Sun, 29 Oct 2023 06:46:01 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 620DE320070D;
        Sun, 29 Oct 2023 09:46:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 29 Oct 2023 09:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698587159; x=1698673559; bh=0mxEqLNYpkEtGR4Posnw0M8UDvrKtPSNjSi
        y1sxuJiA=; b=qcHTygireRJ+119oNEtXJkQOL4JovTnhh4ugALeMKoec5nd1kLA
        fD5jdb4DSiuqE+3JPEeeJpnZJFuWf8EgkjCnbikC7aAZXsIJE0BIOyKt2P9QOjPI
        qfwpTmgfDBQLFfavig6IxHedjzNvfWZWoiAbStktdmX5Ty5h+pbMHUFMGGY28Zy6
        5yCy0ftmU9nBBhYTpjiHr+Z8WNtjPG0Jmrwym7nnVCLuLalYPxR8ua3C49SXAJQm
        qSDlR7nsbw8M3M6MHvm46tAR9SlCU4CxVE5o9c3erWl5PnQwPw8dWT40CFwP/ojB
        qBCWnZwKwgNUQterkSZ8W1FwojOY6UFjCFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698587159; x=1698673559; bh=0mxEqLNYpkEtGR4Posnw0M8UDvrKtPSNjSi
        y1sxuJiA=; b=bJ55o6IRLo32F9p8iFtT2c72V2KZeo0YYdF/ukgMVhz9flSQh7J
        LaJO6hezmKg8S493ldpRGUJfxC0UIh8vgHNUa79r/X2AMchSrK5OnyxvwicSsaww
        0w+2/cSo3Zk3qFHlLPkypKFSmBYfKB/xjTewahyByUNYp9MRI+XwOaxQyW5QRz0f
        TdP/jw2Ks+EAodUBRQ/0Nkd30ZsVpnw5CpwcIQriU4GeKCc9+bB4NC5O1tD1xLTc
        eQhxq/IOLpjICfd/zbeyiZfmmiFFi231fqCCvznOSQDODyKKEiHKAa6EeeyWGA+E
        /XYU0qRjwdfgN3L4cmnDYmA/sHtNq/qXJbQ==
X-ME-Sender: <xms:F2I-ZYEkpEoRyAtV38RkbC84TbZqTmuCWf4Ajsn7Y8nU73ipXFrJXA>
    <xme:F2I-ZRWNkQ3CCJ-ggxneWA1JYVu32mZP5UgUYuBFKM4EH1ZN-0bkpjblSTPjEXOu4
    CDiw6Tx0W7rD7BE4PU>
X-ME-Received: <xmr:F2I-ZSJIdsisLD_-3GDRfJDIBZ7C-whydGZ-UDBMuzW9UW0a8BV3r2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvvddtvdffgfejledtjeevveehieevjefgleejkeetffetueej
    uddtgeeghfejjeenucffohhmrghinheprghltghhvghmhidrshgsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:F2I-ZaGuZt-zzVX5hjmb_9JaczZdGpAFtAr7FwAddHOZScNBv35cLA>
    <xmx:F2I-ZeXETDZMWNfcJCc0bhPuJ1D5f7F2a_jOd8tWMq52MBvzxZ_xbA>
    <xmx:F2I-ZdMvmLFANOpj-TpDMIfcICv0xAeY7X1SI4_mK_gZaUnvYtMKeA>
    <xmx:F2I-ZbipExt6Wm-RvOorYZS7XLt3Of7AO5QLh9jKa8Ng5ZZ-dleYdw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:45:59 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 29 Oct 2023 02:53:07 +0000
Subject: [PATCH 6/8] MIPS: debug_ll: Implement support for Alchemy uarts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-mips_debug_ll-v1-6-d7a491e8c278@flygoat.com>
References: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
In-Reply-To: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alchemy uart is a 8250 derivative that requires some special care
on barriers and readys, also they have a wired register layout.

Implement it as a special include.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug           | 10 +++++++++
 arch/mips/include/debug/alchemy.S | 46 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 3609d298a9eb..aef116058654 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -257,11 +257,20 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on uart0 of Ingenic SoCs.
 
+	config DEBUG_ALCHEMY_UART
+		bool "Kernel low-level debugging messages via Alchemy UART"
+		depends on MIPS_ALCHEMY
+		select DEBUG_LL_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on uart of alchemy SoCs.
+
 endchoice
 
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default "debug/alchemy.S" if DEBUG_ALCHEMY_UART
 	default "debug/uhi.S" if DEBUG_MIPS_UHI
 	default "debug-macro.S"
 
@@ -293,6 +302,7 @@ config DEBUG_UART_PHYS
 	default 0x1fd003f8 if DEBUG_LOONGSON3_UART
 	default 0x1fe00000 if DEBUG_LOONGSON2K_UART
 	default 0x10030000 if DEBUG_INGENIC_UART
+	default 0x11100000 if DEBUG_ALCHEMY_UART
 	help
 	  This is the physical base address of the debug UART. It must be
 	  accessible from unmapped kernel space (i.e. KSEG1 for 32bit kernels
diff --git a/arch/mips/include/debug/alchemy.S b/arch/mips/include/debug/alchemy.S
new file mode 100644
index 000000000000..933efc6e828c
--- /dev/null
+++ b/arch/mips/include/debug/alchemy.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * MIPS Low level debug include file for Au1xxx UART
+ * Dereived from drivers/tty/serial/8250/8250_rt288x.c
+ */
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <linux/serial_reg.h>
+
+#define DEBUG_LL_UART
+
+#define UART_BASE	CKSEG1ADDR(CONFIG_DEBUG_UART_PHYS)
+
+#define UART_TX_OFS	(1 << 2)
+#define UART_LSR_OFS	(7 << 2)
+
+# define UART_L		lw
+# define UART_S		sw
+
+		.macro	addruart,rd,rx
+		PTR_LA	\rd, UART_BASE
+		.endm
+
+		.macro	senduart,rd,rx
+		UART_S   \rd, UART_TX_OFS(\rx)
+		sync	/* wmb */
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:
+		UART_L	\rd, UART_LSR_OFS(\rx)
+		andi	\rd, \rd, (UART_LSR_TEMT | UART_LSR_THRE)
+		xori	\rd, (UART_LSR_TEMT | UART_LSR_THRE)
+		sync	/* cpu_relax */
+		bnez	\rd, 1002b
+		.endm
+
+		.macro	waituarttxrdy,rd,rx
+		busyuart \rd, \rx
+		.endm
+
+		/* Au1xxx has no MSR */
+		.macro	waituartcts,rd,rx
+		.endm

-- 
2.34.1

