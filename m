Return-Path: <linux-kernel+bounces-166270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B85B8B9852
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D35E1C21F16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA656773;
	Thu,  2 May 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="r4HLchic";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwdEI43H"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16A59162;
	Thu,  2 May 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643985; cv=none; b=ftGS6GdkI/8nIh4PF2Xv5H2RhcG/dG8CB/x62elutXzfh/+a3QEZLJKgZFWxNLrMuREZD4KCYZVvPlnU8T99yycu62Pedx6CxQsheKSwsu6MnEzEDZwqeDr6NGUIkmhxywQ3AATy2V76ZpbBgnGVmRDbCQZufoh7HpivNGLmkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643985; c=relaxed/simple;
	bh=dssAdswcFICvMOQneWOD2aRjHwqfi0CLy3Px0yTWsrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oG0OJYflastKcqLuGUlredv3ajLqc58paV7TaB76APPEQjnVNsUYHlm8ypqRSPeYfl9poGrsMLt7uWLziUQtTGbXJ7eoEEgez0uDjQdVNG3punBh7pUIpxLmI0XotilprQPPZgTm4OeXfmO88Za4f5qSdL5ORtBxUyDoSn8bkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=r4HLchic; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwdEI43H; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 271CE1380F77;
	Thu,  2 May 2024 05:59:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 May 2024 05:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714643983;
	 x=1714730383; bh=0mxEqLNYpkEtGR4Posnw0M8UDvrKtPSNjSiy1sxuJiA=; b=
	r4HLchicTleHy0Acw3A7itptHa0HNwC8oQ+Y6fI9lrp9rLdGDOmEyYUVB4RiOvSW
	M0wtbjN4AVdcCaydMhiPL8h7tndHBQELTkl/FerAMrKPfJpmkXv2Kg6HiJSTt003
	qzL2E/a3nQ8BIPhwOkJ5Sr4s2d98RFeWJCnmg0ag9R1vMiwlOQp8m0MqtzJQoE/S
	JJNWMeDjYsSUG0uXYZDPrCrkqjVuWVusTAUfhzmv7RDzZ+laqovSebIDFC4Z3wi/
	B9houdCTKm1EfF0q74GkbPfNEVr3DkehFmNOsu5hcAJbXaAjxYAwB4RvKWgzIUT8
	snj+3O4EaH8V/d1cde4H0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714643983; x=
	1714730383; bh=0mxEqLNYpkEtGR4Posnw0M8UDvrKtPSNjSiy1sxuJiA=; b=g
	wdEI43HuvinBdqDJskjrFTEfSURjiCYj9VYlpVb4zTRi5Sc7iHt5sP1NNobOQQxC
	LjaMC0Fdz/K6zNivBXJYfeO0LeAQR1gzr64NTlATWsu3ZwBiJGKqsu2Z3wU+WZW0
	QV38tDSN1rpcl4OODY8WQjUXYz8eAZJ+EcElpSCKtenvz3vcHQnl/xNhISeYWjY3
	yUngBwhfdHpn/WBNWDftetH7aF4BL9xM8Os23VOtA2nI79Fd1D/KkNOFMbFAu1Aa
	iS/PVRayUAPeSsRWE+lioU2Clvu7S5vodSDyKtbRVwXytUR4w/nLdQRLprDcZudg
	vACVlhHEOHgMZqpp/0eoQ==
X-ME-Sender: <xms:DmQzZsHZuQDRBVFygQXlR2iQQ24TK29cMsBk_Lbn13bHmphkZdjd2Q>
    <xme:DmQzZlU5p6yK9WIpeU9AU0HBqhRO53HOL67RoZ0EEiZHvdhi6AJf0Kj50HfjcsMY2
    tehUrwwt_YgkaGMJZE>
X-ME-Received: <xmr:DmQzZmIfckifa5PV-tizK8rzn76G4Xug0f7xakDxGtwGsoWWpCISdOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvddvtddvfffgjeeltdejveevheeiveejgfeljeekteffteeu
    jedutdeggefhjeejnecuffhomhgrihhnpegrlhgthhgvmhihrdhssgenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:DmQzZuHUBJCKgTLoaJNfWioe9sSgtL3NTm_7v41hf_XA0yRu-Ska2Q>
    <xmx:D2QzZiWOAEONY3aENmCgHOwX5EhNAp1e6pWx85bTwE1FrOpdwTC-2Q>
    <xmx:D2QzZhNg9KfHDDYPHhq4fclNubHFC7tP0Y0eFjt2N0WEr0saqhC7Dw>
    <xmx:D2QzZp2Lf4_Xd2ag_-4YIuPwtDOffj9DDtqJ2f2UHb8H79IsxenbmA>
    <xmx:D2QzZgwRyrz3P4XWP-g3X9qYjuh5UnU1MHQRUIY35EoE8GkrvtcUtvDq>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:42 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 May 2024 10:59:33 +0100
Subject: [PATCH v3 6/9] MIPS: debug_ll: Implement support for Alchemy uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mips_debug_ll-v3-6-3b61f30e484c@flygoat.com>
References: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
In-Reply-To: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dssAdswcFICvMOQneWOD2aRjHwqfi0CLy3Px0yTWsrA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFHZ2AZXdC2Z9Te2ZGbej6vPVS46S926c3ZCxZdcyJ
 nbJFVm7OkpZGMQ4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAi7/8x/LO1Xe0Sdach+ozv
 FRWrwo3t+Yf5MlOi98T9kGu3n5/1zI+RYdsppQ/PkhS2xtQ6JaUy7dtlrXWQ++NrucdXRb+fNGV
 6zwEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

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


