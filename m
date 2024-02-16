Return-Path: <linux-kernel+bounces-69085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1585844C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92381F2214F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF3132C23;
	Fri, 16 Feb 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LCeO7g3c"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D68131E5D;
	Fri, 16 Feb 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105356; cv=none; b=sFrbaJdL1qJrWrJOnjacWmzwQUmebq+ohDF8T5psi/OLDCogq3vih1W83031cEQsxXiH8wW9n5YjJdVmACQQb9WbIYYVx55NZFRHnHyMaejZilz0v3RyD69bAPb/iUFd5GzYYF2YL5hJGOH+R+2gDTOzsMt7BmpL7L3k2GjO3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105356; c=relaxed/simple;
	bh=BOyUr0UPDVUOYNogVV+QAoPG/ry4w9cdTDK057dLQUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+JdZvPe9rs5890OCh1+Soqs7jZJ4JAZc19RoDR3CsgHt84Q4yfEdaoORTj8yPF/9HeF0cFnxnTaLDldHzDY7IlNArSO9cJJBMEjMtal+n2w7XFSGY9IuC0rnSjUZbQ915DT1XlfkmFwtPHe8Toq97PJOh/c8pYyIkmT8HdJt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LCeO7g3c; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAD5FE000B;
	Fri, 16 Feb 2024 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axj8HIASMHBgR5o6/moj3w8Gd2MoT6J/01JlLIK6CjU=;
	b=LCeO7g3cmQ8ws+ptQzzKkby+O9joy+f78CNxM51dRmhL13QhNRpzDpdv5ekU9BAHgaL4OY
	ampfuviabKpB7YgS8wqMILqJWjbhQ3ff977UU/SM/qcp801fEgJ4vnvvvMiJVqZrIs8JKh
	rK8AjsJhvQnbHRKW8iVQGiILDQ6tijpkNNEgP+W0E4JlIyE6xF6DkZ412alLOZ7q95HYfa
	7eNvYHd5qg8/XCNC8ghUuiAHoQ7lUb5zprRVI5ZIAXppw8fsuHtnaK+FYj+CfArct+U/DO
	9+QlL/FsEssu1cnw7tA3gH2au+VIriC+rO3+8Zv/KQuQIBWSVpJPqXLbiY9/0w==
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
Subject: [PATCH v8 01/14] MIPS: spaces: Define a couple of handy macros
Date: Fri, 16 Feb 2024 18:42:10 +0100
Message-ID: <20240216174227.409400-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
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
index 59a48c60a065c..7e9ef01cb182b 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -47,6 +47,11 @@
  */
 #define KSEGX(a)		((_ACAST32_(a)) & _ACAST32_(0xe0000000))
 
+/*
+ * Gives the size of each kernel segment
+ */
+#define CSEGX_SIZE		0x20000000
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


