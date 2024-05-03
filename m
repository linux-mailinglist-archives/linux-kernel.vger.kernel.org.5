Return-Path: <linux-kernel+bounces-167728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2E8BAE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29A11F232E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14061154C14;
	Fri,  3 May 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj/i/dyw"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C494154431;
	Fri,  3 May 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744514; cv=none; b=KkOdhqcEP1ojVaeZx6HWU1wcj8Cz4Abm6JBs5X6Qu2wZMcee7WIGrVdXXtf7R4cX8ROD3zR99ZCjpsSdocNOeEi+nbi1j8qFPJgeMgXFEqvTGD0haonQeZVFwafGd5UhnrcMGlxaS/goXaSc2CH88jfJmdrdJCtJKo6v86+OM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744514; c=relaxed/simple;
	bh=gv9YiYQt7k9cDctcD5dXzh486s2xgjA9UvSaHqBG8PY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4CcKtX9REATKNmrn3vbJMOTz5kQpVf77SMQM33Z5BmprlAKd6wGW1uwwzQ/vHkqbHk+Z/GSqLYrQ6lKSvpZQ/IAr8Lmqaj/fTfom2UeiCrVdXkGvZ13bLEkjhnDZDLZsB1m265MiBBnB8YlWqWqZgwkEPHg2Z/7DpSBFZJL2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj/i/dyw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so54526245e9.1;
        Fri, 03 May 2024 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744511; x=1715349311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=by5Uyw2XfpPL/yXNDPc72M9QG4hAMA1joBwF3oJ0xO0=;
        b=Aj/i/dyw/mv0l+4aT7RaVm+0VyQap/gdRZ1L9VmcsLZmIDcdizXjRUUO9+OpD/3zRG
         vEH05MvKyglzx239rdtI3kj1bzmKMI8flBMuD6lLAbu++XDy7iYFS7UOQrAe4JEdokOr
         hzCMMY7Z38sAWFhm3jUCBzqqYj3pF+jbyJdUIeX7SlrE0yXycgYEWimqF4OOG5h0MuaO
         LgZwaRfteNGEhsJKFyNamxrLqCXXRI96sYRDIGX3fkft6vexNKaGdHAkF24oJlKlyqqD
         uHUJ6/8GQSpg/MUKXmdnDYQuSIPznd2Lu77TqeWc4S3EJWm6LFhTwApCTzFdmqKlHvBG
         NSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744511; x=1715349311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by5Uyw2XfpPL/yXNDPc72M9QG4hAMA1joBwF3oJ0xO0=;
        b=pqqgc/wQnKK1h23kuI/rIMFNHswzZ1BnPWmMHZsC64Z/ClOWjR/wYyiUijs6HRaOXp
         W1dp9y/r++PQGkMTka88mIq3ReEqrJ0Jz+cfYlM5wd8NUuufzXBg6020X74V6z19m7FS
         qHQSa+AianSJlx6P+Bt8ZasdjlJg/zejbmyEWCfIRK9f3CLT2SdwP0yUOJuStq3ebIpP
         XuqI56t2gwc6C0Nk4l7/cBBETvv4dK+t9a9sW5r01axTgZ3vvqVMyMLidmXfS5NG2M/p
         VZdfjeMl4xOWhd+d/kwuIl8VIg5ORot1Cz+nnUqGTFtA1/7h5G/cftdcIeDDkQcTWfgU
         qe7A==
X-Forwarded-Encrypted: i=1; AJvYcCVeqW5tNDrl7A/9dETUBny5Pp7OyiTr0dwnO6DRJJtb2AgzqtqpGh1lWNaZd+EYOAUpTUvOxoBHOjHU08t4cikiXEeJckMi0dAUp+xezxUA3CTlahjQbdjH+QezE5hCFR0h38y5Z1JnpM2Og761Jw2M0hrhL9GSbDiD0vIfT4eG5YAhyog=
X-Gm-Message-State: AOJu0Yx5simKQnFhdk+cfjwLT9vvwEzKqYipov8PC1wJ97mN9lZLljSD
	l0nkqzwnkPw32QJ8BWyn2O0CE0ULtq+k5DvHFVxTVHfQE++Z8cnI
X-Google-Smtp-Source: AGHT+IGjibfDRe2YVGdviu5c/vGoLu9PN2h+92uqjbHwf5Lyz7t41zveMJtrv4ObDQj4iBQkIqbjVw==
X-Received: by 2002:a05:600c:3551:b0:41b:e406:5ae6 with SMTP id i17-20020a05600c355100b0041be4065ae6mr2246869wmq.9.1714744510615;
        Fri, 03 May 2024 06:55:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH 2/6] mips: bmips: rework and cache CBR addr handling
Date: Fri,  3 May 2024 15:54:02 +0200
Message-ID: <20240503135455.966-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503135455.966-1-ansuelsmth@gmail.com>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the handling of the CBR address and cache it. This address
doesn't chance and can be cache instead of calling the register every
time.

This is in preparation of permitting to tweak the CBR address in DT with
broken SoC or bootloader.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/dma.c         |  7 +++----
 arch/mips/bmips/setup.c       |  6 +++++-
 arch/mips/include/asm/bmips.h |  1 +
 arch/mips/kernel/smp-bmips.c  | 31 ++++++++++++++-----------------
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 3779e7855bd7..799cc3e12fc3 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -9,7 +9,6 @@ bool bmips_rac_flush_disable;
 
 void arch_sync_dma_for_cpu_all(void)
 {
-	void __iomem *cbr = BMIPS_GET_CBR();
 	u32 cfg;
 
 	if (boot_cpu_type() != CPU_BMIPS3300 &&
@@ -21,7 +20,7 @@ void arch_sync_dma_for_cpu_all(void)
 		return;
 
 	/* Flush stale data out of the readahead cache */
-	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
-	__raw_readl(cbr + BMIPS_RAC_CONFIG);
+	cfg = __raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
+	__raw_writel(cfg | 0x100, bmips_cbr_addr + BMIPS_RAC_CONFIG);
+	__raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
 }
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 66a8ba19c287..18561d426f89 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -34,6 +34,8 @@
 #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
 #define BCM6328_TP1_DISABLED	BIT(9)
 
+/* CBR addr doesn't change and we can cache it */
+void __iomem *bmips_cbr_addr;
 extern bool bmips_rac_flush_disable;
 
 static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
@@ -111,7 +113,7 @@ static void bcm6358_quirks(void)
 	 * because the bootloader is not initializing it properly.
 	 */
 	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31)) ||
-				  !!BMIPS_GET_CBR();
+				  !!bmips_cbr_addr;
 }
 
 static void bcm6368_quirks(void)
@@ -144,6 +146,8 @@ static void __init bmips_init_cfe(void)
 
 void __init prom_init(void)
 {
+	/* Cache CBR addr before CPU/DMA setup */
+	bmips_cbr_addr = BMIPS_GET_CBR();
 	bmips_init_cfe();
 	bmips_cpu_setup();
 	register_bmips_smp_ops();
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 581a6a3c66e4..3a1cdfddb987 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -81,6 +81,7 @@ extern char bmips_smp_movevec[];
 extern char bmips_smp_int_vec[];
 extern char bmips_smp_int_vec_end[];
 
+extern void __iomem *bmips_cbr_addr;
 extern int bmips_smp_enabled;
 extern int bmips_cpu_offset;
 extern cpumask_t bmips_booted_mask;
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index b3dbf9ecb0d6..6048c471b5ee 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -518,14 +518,12 @@ static void bmips_set_reset_vec(int cpu, u32 val)
 		info.val = val;
 		bmips_set_reset_vec_remote(&info);
 	} else {
-		void __iomem *cbr = BMIPS_GET_CBR();
-
 		if (cpu == 0)
-			__raw_writel(val, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
+			__raw_writel(val, bmips_cbr_addr + BMIPS_RELO_VECTOR_CONTROL_0);
 		else {
 			if (current_cpu_type() != CPU_BMIPS4380)
 				return;
-			__raw_writel(val, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+			__raw_writel(val, bmips_cbr_addr + BMIPS_RELO_VECTOR_CONTROL_1);
 		}
 	}
 	__sync();
@@ -591,7 +589,6 @@ asmlinkage void __weak plat_wired_tlb_setup(void)
 
 void bmips_cpu_setup(void)
 {
-	void __iomem __maybe_unused *cbr = BMIPS_GET_CBR();
 	u32 __maybe_unused cfg;
 
 	switch (current_cpu_type()) {
@@ -607,17 +604,17 @@ void bmips_cpu_setup(void)
 		clear_c0_brcm_reset(BIT(16));
 
 		/* Flush and enable RAC */
-		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-		__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
-		__raw_readl(cbr + BMIPS_RAC_CONFIG);
+		cfg = __raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0x100, bmips_cbr_addr + BMIPS_RAC_CONFIG);
+		__raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
 
-		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-		__raw_writel(cfg | 0xf, cbr + BMIPS_RAC_CONFIG);
-		__raw_readl(cbr + BMIPS_RAC_CONFIG);
+		cfg = __raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0xf, bmips_cbr_addr + BMIPS_RAC_CONFIG);
+		__raw_readl(bmips_cbr_addr + BMIPS_RAC_CONFIG);
 
-		cfg = __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
-		__raw_writel(cfg | 0x0fff0000, cbr + BMIPS_RAC_ADDRESS_RANGE);
-		__raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
+		cfg = __raw_readl(bmips_cbr_addr + BMIPS_RAC_ADDRESS_RANGE);
+		__raw_writel(cfg | 0x0fff0000, bmips_cbr_addr + BMIPS_RAC_ADDRESS_RANGE);
+		__raw_readl(bmips_cbr_addr + BMIPS_RAC_ADDRESS_RANGE);
 		break;
 
 	case CPU_BMIPS4380:
@@ -627,9 +624,9 @@ void bmips_cpu_setup(void)
 		case 0x2a042:
 		case 0x2a044:
 		case 0x2a060:
-			cfg = __raw_readl(cbr + BMIPS_L2_CONFIG);
-			__raw_writel(cfg & ~0x07000000, cbr + BMIPS_L2_CONFIG);
-			__raw_readl(cbr + BMIPS_L2_CONFIG);
+			cfg = __raw_readl(bmips_cbr_addr + BMIPS_L2_CONFIG);
+			__raw_writel(cfg & ~0x07000000, bmips_cbr_addr + BMIPS_L2_CONFIG);
+			__raw_readl(bmips_cbr_addr + BMIPS_L2_CONFIG);
 		}
 
 		/* clear BHTD to enable branch history table */
-- 
2.43.0


