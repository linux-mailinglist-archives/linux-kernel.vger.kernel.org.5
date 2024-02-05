Return-Path: <linux-kernel+bounces-52923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E51849E65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1005E28B646
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E092E41A;
	Mon,  5 Feb 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dC/wt3/u"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D92E63C;
	Mon,  5 Feb 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147312; cv=none; b=Smg+KHJcbGwQRBC8C77yN9AK3lM19mUsTQw8+ZKB72Cv0iPoJfu6sxwvTAJI64KTYbEzFrOXDVqvSX4XXj9f81KRFgp/9/mrILhU0lpdOtfINqk5V1RPAEZ1piGtDkaFYGKgnPuEsNpI94BizvhV/uRRjoXszNB8CBlzyu+Y2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147312; c=relaxed/simple;
	bh=CaXBWxsO+R6feKBnilzrnxufzQ2BLnDif1KfoyMON+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhhAMsfnPuR+MLGkbFjy6diM9BzollDvwQ/mnTtnifWhKDSosbQfO2as7TE6dwL+1J13pxoOMqxajfyDcZ69Xz988flsg7nqZXaJ1Lu4cq71fK5zCnLq+c9dGDdC1soeHs1V0k8xMtYuTYk/xAu51vPqsymWbsBeeRDVeBqhtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dC/wt3/u; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 430F81BF206;
	Mon,  5 Feb 2024 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JyLWvT61W6ZBIjMo4xtHJF4yqj1qVU6xtbzha7IAjk=;
	b=dC/wt3/ujt8P+jtn7s/fQM6YzkfK7oECQ1q/Oq27Hk0C9IitLAeKbchmOBvHpaS0sKRjjb
	w/zGECBhtoZfBoknbB/awF+NzwKvT9jn9yaJS3y2V/UdMenhe7lnV1PJsR2bpjcjdBGSE2
	WnOGqZBdfWM36DKCaaTD6GyEXIjfqbmOiT2Dgzd9pz9uKHqiKmNGFxliDeTKx4NbywNip2
	+YPxWG4LTpjYclxV17ySWB8BCcado1pJGvKkMyXbvbvkgC9iI3eF06RVTS8KMHZrH4G+eE
	VdrmUDpyl40LX9SehAJ+OjHSMZ1FydHEMJNg+yi2MSgSCO9uYat04sQ5xWlVsw==
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
Subject: [PATCH v7 01/14] MIPS: spaces: Define a couple of handy macros
Date: Mon,  5 Feb 2024 16:34:47 +0100
Message-ID: <20240205153503.574468-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
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


