Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234CF7DACAB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJ2NqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjJ2NqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:46:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E6BF;
        Sun, 29 Oct 2023 06:46:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 59337320027A;
        Sun, 29 Oct 2023 09:46:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 29 Oct 2023 09:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698587161; x=1698673561; bh=XPw34Iav2T+hzoHR6mAbmW6CU2TVaqRpR57
        TvU3su/0=; b=BwY5WxrQ6pgPiGsUfBkHxT78tKE6bnMvKstG/Z4lHs2ePbcz21v
        Q3Vmri1QIwwn4AhXk+s+WZYbSSyRFmt06e1LBEK19dU3ipz1G/JHfr9e0YG7b9lM
        Qgt716D0PPipMTZCY3JW1jDpRHiMjosp+ywVrab/zXG8U/YETNHDxqD7g7j6uey4
        5KbGYfcApsQUL3Mqv+ls49Rjyyrqy47V3BwxNUq4utl/enQjMcbiWn5Osd/xacMR
        VnTWsBPiP2fINOHD0im2DwGRHHm1mLaUSxDFz3yncFV3b1eNsRuab0geDrPqZ+6A
        rFDADMy5QFWwWO1OG4mR3bDHVpvmaIK4cjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698587161; x=1698673561; bh=XPw34Iav2T+hzoHR6mAbmW6CU2TVaqRpR57
        TvU3su/0=; b=KQZE+ZZmUIVrRL0M5r7SDl7pQrEUg1tUw4xEvrrIi6Ub66XQw8c
        DWhaJmRWDNjeJvt4+w3vZIs7xJG0P+UI8DWdzCRM+gF/3x4Ro9aGE5ovOx7UVaND
        X+V+BHG69xQs4f+geeyuJd0FMt63UNgRrZLGoAEYyIsxxOGO/2ffv6pSXtF+c9A7
        3Jv6OyPGWdxH+DP2QF8V0NXt7gI5t8F3TheIsfkSHAMIXtQlDUFse2S70qPQyVzZ
        6OJofY21J9OzMunoCYJ19cqnbBgKv5ULIZ/eadJBYBlQIgWHkFdcX3wSe45ZJyM1
        nPcBIIVH2ngLN3wqgt1dU4X0/ik9JAmFNrQ==
X-ME-Sender: <xms:GWI-ZSUWJcNN0la8ReJxM2h4yp1AF_0neOkVmlQqqPRR4KHcl5ibUQ>
    <xme:GWI-ZenHwTDhshgQ1dGp1TYxgio0aG4Qk53wgNZY_DAp52zzDZX-oUcJZa7MQleoF
    lrTAkikU2PTg2dvSd0>
X-ME-Received: <xmr:GWI-ZWbMSSwBQqfttYlIEnBkeb_m8Vh9SJuIZmXhunV-rfBsVAY4Hhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeevvdfggffgtdeuudekfeetleffkedvveeljeffjeeigeekfeff
    vdffleetieejgfenucffohhmrghinheprghrleeffeigrdhssgenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:GWI-ZZUX-0-cnQ2ZgtQfEK2gS-Mg0Ff7-ORipF9zM5ZIGKuaCx_GXA>
    <xmx:GWI-ZcmsuNS0E4S0CpdbmACdAWMe0DKyiuZwLf3CkxxFBazFpIz0fQ>
    <xmx:GWI-ZefDEJbZB54oJBKSMuuMGZDJ9fu0Pbt3IWn6hzAVccyqflUUVA>
    <xmx:GWI-ZRwq96u8Uhq7N_M2a_rHvASjoEFOLvtXbycTn0Z7h2AUualtSg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:46:01 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 29 Oct 2023 02:53:08 +0000
Subject: [PATCH 7/8] MIPS: debug_ll: Implement support for AR933X uarts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-mips_debug_ll-v1-7-d7a491e8c278@flygoat.com>
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

Implement support for AR933X uarts which has it's own register
definition.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug          |  9 +++++++++
 arch/mips/include/debug/ar933x.S | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index aef116058654..a6687c503c34 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -265,6 +265,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on uart of alchemy SoCs.
 
+	config DEBUG_AR933X_UART
+		bool "Kernel low-level debugging messages via Alchemy UART"
+		depends on MIPS_ALCHEMY
+		select DEBUG_LL_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on uart of AR933X SoCs.
+
 endchoice
 
 config DEBUG_LL_INCLUDE
@@ -303,6 +311,7 @@ config DEBUG_UART_PHYS
 	default 0x1fe00000 if DEBUG_LOONGSON2K_UART
 	default 0x10030000 if DEBUG_INGENIC_UART
 	default 0x11100000 if DEBUG_ALCHEMY_UART
+	default 0x18020000 if DEBUG_AR933X_UART
 	help
 	  This is the physical base address of the debug UART. It must be
 	  accessible from unmapped kernel space (i.e. KSEG1 for 32bit kernels
diff --git a/arch/mips/include/debug/ar933x.S b/arch/mips/include/debug/ar933x.S
new file mode 100644
index 000000000000..1a0449082080
--- /dev/null
+++ b/arch/mips/include/debug/ar933x.S
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * MIPS Low level debug include file for ar933x UART
+ */
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/mach-ath79/ar933x_uart.h>
+
+#define DEBUG_LL_UART
+
+#define UART_BASE	CKSEG1ADDR(CONFIG_DEBUG_UART_PHYS)
+
+# define UART_L		lw
+# define UART_S		sw
+
+		.macro	addruart,rd,rx
+		PTR_LA	\rd, UART_BASE
+		.endm
+
+		.macro	senduart,rd,rx
+		UART_S   \rd, AR933X_UART_DATA_REG(\rx)
+		.endm
+
+        /* CTS and RDY are handled by AR933X_UART_DATA_TX_CSR as well */
+		.macro	busyuart,rd,rx
+1002:
+		UART_L	\rd, AR933X_UART_DATA_REG(\rx)
+		andi	\rd, \rd, (AR933X_UART_DATA_TX_CSR)
+		xori	\rd, (AR933X_UART_DATA_TX_CSR)
+		bnez	\rd, 1002b
+		.endm
+
+		.macro	waituarttxrdy,rd,rx
+        busyuart \rd, \rx
+		.endm
+
+		.macro	waituartcts,rd,rx
+        busyuart \rd, \rx
+		.endm

-- 
2.34.1

