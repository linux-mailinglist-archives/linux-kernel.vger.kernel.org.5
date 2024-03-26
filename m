Return-Path: <linux-kernel+bounces-119937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61188CF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBC0B267A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0E13E3FB;
	Tue, 26 Mar 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ah/wqvCN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBPzO+SN"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02B13E031;
	Tue, 26 Mar 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485344; cv=none; b=Qzk/nQDSf2udmo96E9zGlvW+N1LwpNeuFqKByg4FOAPEXzFXnLr4c8TaE6iNstyNjXiSwtbtfktGmMmheX6Yc5JrfOkN4Atjrdbw4BxmoXwTfs3F1hZqkkWXoK3XwbXWwh7WFakLz/dx4O2tgHYHHKHlmwmzzTDwruUxosp3pEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485344; c=relaxed/simple;
	bh=dssAdswcFICvMOQneWOD2aRjHwqfi0CLy3Px0yTWsrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFcM9hIb1dz6SzbIFIdHb0p6CcYvH37L4gG5gmVdxFtHNcgmfITP96Tu2euO6Y2u8EVTCUajujE2GfbmtwnpzoITZKvF2xVCaEFRt8DqXGUsJZFisGlzuw6o1ZdY5a7RLJI0agAh9fPjzF4l+1WbSmi7g05diL94ROSKuCBKPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=ah/wqvCN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBPzO+SN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 130F11140140;
	Tue, 26 Mar 2024 16:35:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 16:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485342;
	 x=1711571742; bh=0mxEqLNYpkEtGR4Posnw0M8UDvrKtPSNjSiy1sxuJiA=; b=
	ah/wqvCNTsJBs/C+qhSSfy7B/q68o2YG3pSlHLkOBoflz8nuf4UW35g+UuCjbi2L
	vhSpsZf7xabmpa6mD5IW7P54TEckb80b21wiTwee7kIL629aYHBxVNvHQ6l2WF2U
	v7yAZaM8Am75rNFCxZSYlxp0Fri6jIXoIFZxu3dgekgdYsz5DzHqfbRmsnYkfcWl
	zGGls2G0ooO4ewx3Pm6FOe0l2pqqj4kSgOdxDNbsGNySeyP9ZJTB01dpbQDhN5ul
	9LZ7Jqw5HEaHUv4hVcxLtLa5cMyfd5LbF+F8FjcrjKWfLNh4KJq1UtX6BiC5q4/f
	tGs8sizPRmHmTteaBxafiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485342; x=
	1711571742; bh=0mxEqLNYpkEtGR4Posnw0M8UDvrKtPSNjSiy1sxuJiA=; b=T
	BPzO+SNpINHEpYJ7l5UFhES7MLo8YofvSTpAY7IXK++BacXVHq/1Iewv2hAHJcI2
	FRROQoViSVbVDzUV0uSkL+cz2UJwhhgB2OPfFBJE7LHP+6RriGUXcHpRXXC95yi4
	rg28rezuroyRKVWktREUGeg/6Ldp9+pqBO5CNwY7OWxe63GkCvjBlBx8IE9Bha6R
	tJwHD+XU1gvA9iQRCzz2gBD5948fUimG6BMjyOaZ2IhwmnmvWk0jG20nQUFaMPa1
	xeRlYBL7AIOA5GsrjUqpNhv+v02tHQ8IHWUq+aYeVjne8y6D/FpSpcd0fv+oABW/
	HHxXeBuhacx3eJYCnKWkw==
X-ME-Sender: <xms:nTEDZj9Fsk-O72tDtuwvSyq7t-LoPRvSUGxwARGmuKt32w9zzhyd5Q>
    <xme:nTEDZvsxKNlcXLaSwm3r0DH1yt8feu-7eS3_EFxokx3xAmE2hK0oZciAEYZ6XrBB1
    7xgIllH9jjkQho5wcE>
X-ME-Received: <xmr:nTEDZhAiyUeE2rscXLAKa39Nlyff-jcewZwJ47u5oANChHw3wQU-iwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvvddtvdffgfejledtjeevveehieevjefgleejkeetffet
    ueejuddtgeeghfejjeenucffohhmrghinheprghltghhvghmhidrshgsnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:nTEDZvdM4dB7MAfvNPtWnn3J3oNBXhH43RKkcF4cA5Sb3Ck7ummbUA>
    <xmx:nTEDZoNzC72zB6Vk83p4YXC14LJsjk8SIpnDUVFCaMBjn-UZy_TF_A>
    <xmx:nTEDZhl9Ul_hP9S9oTwIBt62x0ET8-zDTOE7kUfNWNfXaLPx1Ogm4A>
    <xmx:nTEDZitLLSY-w71ftDIckmfxaWDw06gst1clqOEUSDfergVjrNms6A>
    <xmx:njEDZn3cR-GMcFBv9WmuVBaikPgLspymki_IvbvcfSZCf15YsPaeUg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:41 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:38 +0000
Subject: [PATCH v2 6/9] MIPS: debug_ll: Implement support for Alchemy uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-6-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dssAdswcFICvMOQneWOD2aRjHwqfi0CLy3Px0yTWsrA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5n/nSM3JO8ovHi5unt2Z+SCadbPqz/JP1zse3fxv
 Kc6n3smdpSyMIhxMMiKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEIvQZGVZOfNf2eU616O7v
 orfjcrLqmDfrh8/xulUkd77ennPTjDSGfwpW83oWztd02Wvz9WDRVT7T3v2OktyHbb2XLVVbeMD
 0DQ8A
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


