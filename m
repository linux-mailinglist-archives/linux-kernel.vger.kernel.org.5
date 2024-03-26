Return-Path: <linux-kernel+bounces-119938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F288CF23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A446AB26E76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27613E6A0;
	Tue, 26 Mar 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="lADohVC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtEC46Vq"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731813E04F;
	Tue, 26 Mar 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485345; cv=none; b=rG1xflvxGvnCQWmTBgbBM/kGMUuMJ2ZjZh8g0IcvqDi6YEesT/lvq+RKFNuu3d1OYI0JVQY1j2s6C5ClDEUMpFikZrCvNSfk52eiLA2sYsVlZU4gux0E3shXQqzUZAQn4ZGtFhfUSzVRXbm/LkLUk+HKlM8V/XbvUNaMySlLpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485345; c=relaxed/simple;
	bh=7F+0NOYc+OjzTTyACC9ErsZ3xLNN6M7QVx5gFrlMcZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVAsxo3GSWMuujUc4+fgzvftPo4ZYcvoHHyy7JQOHYfA7nWQfBWzOPrS9SsNz43jdjcKF/i/iFnAPNkl+bk1xjoMFjMIlKCSUW3jVykUtGYZMD/5OZ7U2tV9v55BqN63So6/QsgpzjCSidJNY26lnXPDGkIK0MRqu1iiWCNhYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=lADohVC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtEC46Vq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 175FA13800CD;
	Tue, 26 Mar 2024 16:35:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 16:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485343;
	 x=1711571743; bh=XPw34Iav2T+hzoHR6mAbmW6CU2TVaqRpR57TvU3su/0=; b=
	lADohVC74ISkyV8Hkx2ptCxrmeR6ijdii2NUUhk4LeFCJV0iXMfIAy1m9LubbFmf
	IWSu+niMwyR89b/v6L/UFM0kEhsPihNFjZxCsXGT58A4q/2IU9n67c5M8tJRYqTG
	ZTfLyuzNq8ORQxGUvkTnPCk6fnhySaFk4B31gjll6u7VEfL6DKfSG1k/dOuex+qp
	7dfyXvswk9/PCcE8ukXo4TR/fwXrsiWK0TK0m+qH+ATa56LBuYVbDeQaXSRL5N/W
	KXNQTl4hzvxc7X94zh3QGFWDQinDEQJjBjibsZNICk4L+Ho2IjP7grTpSWOjTyoZ
	HG+J8svrOTGBNW/uoj84rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485343; x=
	1711571743; bh=XPw34Iav2T+hzoHR6mAbmW6CU2TVaqRpR57TvU3su/0=; b=L
	tEC46VqCB46cELB2UyUzaSHRvPljiZhxPRaXkllmsq3iDJbW7NQ85Au5p+NPJpIk
	mVww0y6Pkww93qa2hrpPh25GELwBWUysjpQRF0P+bz/KDTpnt9ADwW/NblDr1b+l
	21NuVAoIwYr/nxt6NqBPU3lpsnTI2NyeJYV8FV7V4NUVD601mvQtfFGeEPUMcn5E
	TfqYpi34K8gKbGW8dzRS/DUhwN/wwEUCJJSQ540q3q+4yTenXuWd+uEztba8OM38
	ME2TypaEJV0xGctodYSP3qxQuwArGBV2a1aQSlYwQzXOMB8SKI/zPf47/PwKQgFv
	25y5sNGnpN35HXw+xPo6g==
X-ME-Sender: <xms:njEDZlYmJtLxRIVx1FKJN-2oEJCmi_GPe9ZTjp4ryPsMNv4cjrQZhg>
    <xme:njEDZsay7fOD24RVOXsQfaW43FrKesJ29jE9EOz4pSXFw_mE1toqiMK5yYcJ7sISK
    6DKPqWXyg9zVIIkZ-I>
X-ME-Received: <xmr:njEDZn9au-S1JGzzfLpbREPn54Amiks3R4rChw6Du3gsdA4jA6dq7UY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeevvdfggffgtdeuudekfeetleffkedvveeljeffjeeigeek
    feffvdffleetieejgfenucffohhmrghinheprghrleeffeigrdhssgenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:njEDZjoOC4up3xfvEoGiXD5XJNEj_hJrzoPYmmpCaUu2ci7lEorLlw>
    <xmx:njEDZgrvOMit658X0YSTT8xH0em77Sjf5ZBvzjpKVQzzp5bSg4saCA>
    <xmx:njEDZpRfH_GSAU_fm-XpW_EbIjcnrOHOX6rOIoNxVn9h33dnzjMYWQ>
    <xmx:njEDZoo7SMEB3tOnx6V5r2tyx9W-hvoUIxAERon1OLYQCQSk9Tpc3w>
    <xmx:nzEDZlBK9F7kWtO_grNPdSeK630pNyI5SDgwoDjAsQ5DLfxKa__K3Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:42 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:39 +0000
Subject: [PATCH v2 7/9] MIPS: debug_ll: Implement support for AR933X uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-7-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7F+0NOYc+OjzTTyACC9ErsZ3xLNN6M7QVx5gFrlMcZg=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5mX1K5ckbjhVFv7+6jfsQWBmRsv7VQVz8qY8y1aU
 CEuLHZJRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExEYwrDP12Jjzy/ux9sKv0f
 XRaxvNW9fNL8z6f+Ja7pCn3izDB7xXeGv6KzxBU3n9gp8GjD+cmPep/ZXr/x+SrDxj8CX99H90a
 4KzIBAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

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


