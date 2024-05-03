Return-Path: <linux-kernel+bounces-168239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C48BB58B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C83B20D38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC65B5D3;
	Fri,  3 May 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyra5cp8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341B535A8;
	Fri,  3 May 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771370; cv=none; b=HkA94cbWwM4I8B8kG+pTBBoY1SSJqtF15fCOyHohI6Z1PFLtKuZfbYWhHxZz5j6+8eM76L+YZc/hySbwb4UJ+EPJh1jGMThsi8NaYc9M51kfON8lcYr8uV+aDuR48iOU7niN90+ylS3yaiZIh2XkCGl+8lbg6rZL1qgQFZDzuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771370; c=relaxed/simple;
	bh=Xxb5B1PVv3ZrUpQx3bfg4axKGi6vbSVIyt8IQLWih4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9ieUTlwj4npslCCboTYMyEmZOjrHshKiTYcolTyYnGLHelIDq/gCaKlWgg2QmtU6YQFNWZ+jLut7lhT6+Eupnzoeq2TCf2xBwIJ6+tiebeY8I1PnCp3EkJiDDunsDPjrbgXr+A+q95tRywSACAFBYos26iDj0kwH/qbo2hWDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyra5cp8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso1620555e9.2;
        Fri, 03 May 2024 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771367; x=1715376167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvqBlP+Rap4YCxg3VeyVH5MXjUjdXiTwdd//z8REzBo=;
        b=Lyra5cp8kv3c/0NJvCeB+50hgZr5UkKvvSJ2KXqU2+Mi8+zk1Pe4LBL0c2Yn6XQAqj
         fepHyBQ9pVXBNDVuKXl0K11Gh5We4d3lcUxgdmCKV1KboNQsO1VlqQ1thDc2p+xY21z+
         pTeTLozXbIWuzCF8Nal+N/2azMdXPmKIHRSTSxPNxRLHRUOo+ZvG/4QE0ROUDHKbsiq8
         A0hZ73wN9ubazq8MrwFDnszgjYsng8hlfUgxoXd8PWN5S6ebrxMUnQK6eZ+a3sMrIo3R
         OkA2bVM9yfkB1ORKgX2kJM5mmFdklkaa7WpGOybrLOA5nYzjp43jpopi9GYkBbVR5C/q
         +i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771367; x=1715376167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvqBlP+Rap4YCxg3VeyVH5MXjUjdXiTwdd//z8REzBo=;
        b=Yp7x3Fum+QxlFM8sgUGqMNzD2kEwFKjFClUur6ebScMpOOVnTtprpl78P25a5PIjHg
         d7MEDmeW5qsRZ31EJXIJjDzrnxeD9xdiJ6sRFleZPKHbSNYmeIc8hY65YcVpuu8oRnMO
         gdnF19XAMuaVoUtDPlMZAUcqDeUbG0RS1jCqKzDP7zlx4QzQUMqr4LjH20Bnfhbqiaxg
         RYyDLe80oOS2xTda0UWuFODg4NuZ2LeQBX+cncVuek9M7vZWX9izlM8J3yedbFkIHN8G
         +kEXCfJg4pV9euGRmX10R5yez1wOErPQ4aRcXO+TYHQ1f80+OHQHKtinqDWQR8xU4YCP
         bEAw==
X-Forwarded-Encrypted: i=1; AJvYcCVKT52VGFWoXXkXMXIZKc1R+tALEbgUKMgX83aeRe8nsN9xWTJFuwZbphm0E3Z2cMi3lAwX+cOLL6KNqIlIaNqoKbAKKsq9k5F2fUyEt+nBW2Kz+ItD46fyYOECrhACktPT0YJiftgZtqnKs2/aqZ5XqnFiVlvKrdYa8JQ2nhtNN303ejo=
X-Gm-Message-State: AOJu0YyprLE8wJKTJdpXchRJjjjQCsl+4gngzJVGJOsO2DQNDDqYoYQm
	k/W/CVzBGo/Twk7sAPsh3TyU1mdpanVmAxFPlI4TKTILYcjc4aUa
X-Google-Smtp-Source: AGHT+IGxK0EXO9VRda6KrcDmFQ9h/UydwORWCmkITvgU0MCesWPoC68C943Qb+Ay9tg3ufldOXO5xA==
X-Received: by 2002:a05:600c:354a:b0:418:f991:8ad4 with SMTP id i10-20020a05600c354a00b00418f9918ad4mr3007987wmq.6.1714771367489;
        Fri, 03 May 2024 14:22:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm6918729wmq.35.2024.05.03.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:22:47 -0700 (PDT)
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
Subject: [PATCH v2 2/5] mips: bmips: rework and cache CBR addr handling
Date: Fri,  3 May 2024 23:20:58 +0200
Message-ID: <20240503212139.5811-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503212139.5811-1-ansuelsmth@gmail.com>
References: <20240503212139.5811-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the handling of the CBR address and cache it. This address
doesn't change and can be cached instead of reading the register every
time.

This is in preparation of permitting to tweak the CBR address in DT with
broken SoC or bootloader.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/dma.c         | 2 +-
 arch/mips/bmips/setup.c       | 6 +++++-
 arch/mips/include/asm/bmips.h | 1 +
 arch/mips/kernel/smp-bmips.c  | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 3779e7855bd7..2bc9c0d4402f 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -9,7 +9,7 @@ bool bmips_rac_flush_disable;
 
 void arch_sync_dma_for_cpu_all(void)
 {
-	void __iomem *cbr = BMIPS_GET_CBR();
+	void __iomem *cbr = bmips_cbr_addr;
 	u32 cfg;
 
 	if (boot_cpu_type() != CPU_BMIPS3300 &&
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 66a8ba19c287..5e024399222f 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -34,6 +34,8 @@
 #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
 #define BCM6328_TP1_DISABLED	BIT(9)
 
+/* CBR addr doesn't change and we can cache it */
+void __iomem *bmips_cbr_addr __ro_after_init  __read_mostly;
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
index b3dbf9ecb0d6..a4f84667a901 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -518,7 +518,7 @@ static void bmips_set_reset_vec(int cpu, u32 val)
 		info.val = val;
 		bmips_set_reset_vec_remote(&info);
 	} else {
-		void __iomem *cbr = BMIPS_GET_CBR();
+		void __iomem *cbr = bmips_cbr_addr;
 
 		if (cpu == 0)
 			__raw_writel(val, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
@@ -591,7 +591,7 @@ asmlinkage void __weak plat_wired_tlb_setup(void)
 
 void bmips_cpu_setup(void)
 {
-	void __iomem __maybe_unused *cbr = BMIPS_GET_CBR();
+	void __iomem __maybe_unused *cbr = bmips_cbr_addr;
 	u32 __maybe_unused cfg;
 
 	switch (current_cpu_type()) {
-- 
2.43.0


