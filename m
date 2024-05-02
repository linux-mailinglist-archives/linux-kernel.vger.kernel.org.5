Return-Path: <linux-kernel+bounces-166271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4158B9854
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066811F24978
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972FD60BBF;
	Thu,  2 May 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="TyBzsE2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TseUbysy"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CA5C61C;
	Thu,  2 May 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643986; cv=none; b=JaJoZFRcF25OQ+AndG8CksFu3GG/8deM1QGf+C9nanVg9DfK0qaJwHUnG2d60Tg90wzOZgjr06iKorpSIKFIL33bMhJ3+7R4o9jK5EQeOQp70Qzjx/aWF6m0G4IUKgA4PSWeDxO0HFp/Ujam/Eoo0Rho02cXlNCi2deqiOv+LYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643986; c=relaxed/simple;
	bh=7F+0NOYc+OjzTTyACC9ErsZ3xLNN6M7QVx5gFrlMcZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwn3bdzrzkBA6HiDVQ29CvjKAeKZEIKWmRdUc6pKodnFgEkJtU+V6Qivua/drjVxgJyNXB3/03R3QSAtO9iramctqidBTiRHGTwX9NbQbMu4dAnCArnnSAIxTq8pMPD2v1p1m1i/2EIQe9uLJSCpkwFRlX/2RkQYkpxS2MdNaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=TyBzsE2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TseUbysy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B9101381120;
	Thu,  2 May 2024 05:59:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 May 2024 05:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714643984;
	 x=1714730384; bh=XPw34Iav2T+hzoHR6mAbmW6CU2TVaqRpR57TvU3su/0=; b=
	TyBzsE2WpwbEN8lFmjEw7oyzQGt9c9GCvOFxwNlQgaCr0KUA9/ponKP4CEHGwkog
	s5F5FtFeUbLnspK2djWp27YEdNcj2UjhHfQgOtVE4BLInINLvDmyKh38EA67q1vu
	DaB7bKvhyeozcKFGysHQgSCAalHnLWJNpw/vyUmLJARulClzEI+/GUYAKdX/VGSQ
	wA3Dnvluf4DaRcjXBBYSfiyM4r9lLBYWoDbfPVJaATRYfBfaQdiviDmy8tQVEsQo
	Dxr9+uBOZ4cjOHRKNiHAeKSxbFZTNQnH7J2clf6/WbictHhb0NUeqE1+8Rj2ibm0
	EmfjTsJXhCGjwELgsYXpUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714643984; x=
	1714730384; bh=XPw34Iav2T+hzoHR6mAbmW6CU2TVaqRpR57TvU3su/0=; b=T
	seUbysyB0H54k/fRmvibOowl0xRzS3RGvxdoD/joGrz6aIR/2271sjWQZBbfxSXR
	egHPVUA9i/GE0uNE6KdVHgZzkiMKGZlKHWEY4hi58pKeRxNJ87DpdJLscmyNya+G
	iKQenLKvtPF/wU3oUU+VufXQyzwNgK1lk5wES5BmVgvrwt1QiNXtBvb3CheDTMWF
	33djKD/HhsF3XatML7ZJ3bTZ3hq31O14zZ5PVKuOgvjV9pwdKlbeCwJQQvAmo02Z
	kSG/kj6R2pbyVeYVV+pJbVHYJ5s0WguenfDrV5w8HQfrxncNYFSEJpEXTM7RxqGL
	lr7x2gppjrrrLZtHN1XGA==
X-ME-Sender: <xms:D2QzZgLwOL3i7OJ7ZxDN2qCYNK8DEurPsCTorNBJXK9q4WmvMOHb5Q>
    <xme:D2QzZgIZrv7OTnKdbJ1bxuOj4k8HYvOsc6p-yhsx_vp6z_8ib3ZKLVKvRYNoFNmoV
    sPCjE26UeizNWSG2Ug>
X-ME-Received: <xmr:D2QzZgvK0Jv7xml48WycNchTMlTOAwoEvJZnOJxyAI2ctJnwWT77KZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvedvgffggfdtuedukeefteelffekvdevleejffejieegkeef
    ffdvffelteeijefgnecuffhomhgrihhnpegrrhelfeefgidrshgsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:D2QzZtZUc_4b0ItIc9c_702BX7oHjglxJ4DVxOj-4LAsGonBT5isig>
    <xmx:D2QzZnYn3_qugG1Y7UgFEsNPWvXbXly22yL0pMFsB9o-5Av6B-uf1w>
    <xmx:D2QzZpBtJoTki4e4rZU1jA5KSVcClQQviDIA4GEclzVWBBGCIe1sVw>
    <xmx:D2QzZtaXKR4ZD4AyPeYffKW6kot0Uqa7lqjO0s7lJJLyjsKBzcnXYA>
    <xmx:EGQzZmULiumSdBdiVXLUVQ-TBTUU-Tq418XCZEoA3RPRJ2MCGpZjRVnK>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:43 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 May 2024 10:59:34 +0100
Subject: [PATCH v3 7/9] MIPS: debug_ll: Implement support for AR933X uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mips_debug_ll-v3-7-3b61f30e484c@flygoat.com>
References: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
In-Reply-To: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7F+0NOYc+OjzTTyACC9ErsZ3xLNN6M7QVx5gFrlMcZg=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFPbdD07naCTVSFaVB/Clvb4tvXP+Y5sZLHXGWs8zN
 Lem/drbUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABPZ84jhf5jXGa6NtufELu1b
 NUnx8k/Z51JFt9tWX+4+w/vhf+T8gBUM/8zbT7Ok5vO4Fy4P3XBpUZOV7Lv9Fwx9s8rr2L77bBO
 oZQMA
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


