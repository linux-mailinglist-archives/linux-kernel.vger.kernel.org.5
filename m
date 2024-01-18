Return-Path: <linux-kernel+bounces-30303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFEB831CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE621F225F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924328DAB;
	Thu, 18 Jan 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dem/ZL1l"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB524B5D;
	Thu, 18 Jan 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593192; cv=none; b=MvIEa0EZv/4ybif1FwzOe/8dJX1ybvil6uPNz8R6PbM08hLz+Igj4dcctxO1z/nhNYjJzFGhuGrBtsLaeY0VxfTgWtXUYrk0fbinBGCrgfIjBno9Tnud56EMfx1OegKr6Pw6RkzwgHxsYsuWxwqVmUQq47BDU93YTIfj/PtSkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593192; c=relaxed/simple;
	bh=CaXBWxsO+R6feKBnilzrnxufzQ2BLnDif1KfoyMON+g=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=lhDahjjEzHJ6jaIsBoxf503XhVAQkpcdBlcxEUjA8+3ZnxCHBp8z8eXwQofmfinhVyJvy2EdAJnwca6tQZkvFfs73hhuagWJLiQ1ICdzUT3IkiFafQ/tsl63lcS27BV7F+QJAZxljDuJ5Ve+II3k62MHDL5cmZbYVK00ya+Xho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dem/ZL1l; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CAA8C0004;
	Thu, 18 Jan 2024 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JyLWvT61W6ZBIjMo4xtHJF4yqj1qVU6xtbzha7IAjk=;
	b=dem/ZL1lrmT1vmTVkw54xDtbDOu80E0Yp7X/oldeTtoNFuGbH/bqvVCz0R31Uxe89FkNuS
	3UUheL+XkD0Xg+jYBh+txPUsuFllrCChU1rN4Lz+XODuKbdy/za4SAxs8b/yzB2PGbmB2y
	N0HVc56SKMdyjAJ22Zl+CZZGqHGQD3w3RXJXsrkgcO7mUHlv5RmEQ+YdqupsK3ywJAB7Ct
	Evkg6/TucBW8NYPgHFbV5+EHIesH/xuuggZF9v2QTCa2Azm7T1DCNz+NM6OAg7kWdnSnlx
	ZjtQa0f0DttkrRuZahdGSTcGT0vs2IjGbOrNKDpuu7F13F4ZLbfBKUuJ3btDcw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v6 01/15] MIPS: spaces: Define a couple of handy macros
Date: Thu, 18 Jan 2024 16:52:30 +0100
Message-ID: <20240118155252.397947-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Define KSEGX_SIZE to represent the size of each KSEG segment.

Introduce CKSEG0ADDR_OR_64BIT and CKSEG1ADDR_OR_64BIT to get an XPHYS
address in 64bits and CKSEG[01]ADDR() in 32 bits mode.

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/include/asm/addrspace.h           | 5 +++++
 arch/mips/include/asm/mach-generic/spaces.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 59a48c60a065c..03a5e2c8b5dc9 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -47,6 +47,11 @@
  */
 #define KSEGX(a)		((_ACAST32_(a)) & _ACAST32_(0xe0000000))
 
+/*
+ * Gives the size of each kernel segment
+ */
+#define KSEGX_SIZE		0x20000000
+
 /*
  * Returns the physical address of a CKSEGx / XKPHYS address
  */
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index b247575c5e699..f8783d339fb0d 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -49,6 +49,8 @@
 #define HIGHMEM_START		_AC(0x20000000, UL)
 #endif
 
+#define CKSEG0ADDR_OR_64BIT(x)	CKSEG0ADDR(x)
+#define CKSEG1ADDR_OR_64BIT(x)	CKSEG1ADDR(x)
 #endif /* CONFIG_32BIT */
 
 #ifdef CONFIG_64BIT
@@ -82,6 +84,8 @@
 #define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
 #define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
 
+#define CKSEG0ADDR_OR_64BIT(x)	TO_CAC(x)
+#define CKSEG1ADDR_OR_64BIT(x)	TO_UNCAC(x)
 #endif /* CONFIG_64BIT */
 
 /*
-- 
2.43.0


