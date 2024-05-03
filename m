Return-Path: <linux-kernel+bounces-167733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5D8BAE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831F11F23254
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1215625E;
	Fri,  3 May 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxBbyXU3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E224155348;
	Fri,  3 May 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744519; cv=none; b=MVqxoXfQetx1cLubukjfIkUn1kDQmNpUlLnGX6vafDJ1Znn4ejgXPNMUgksLvlj4+czOHxwMTtERZWBBeR9I4xd/WlTHmpAVJy2xkzOg9SDDcb1muDrTpJylRA881M4A1O/La0oN0RvShImhbvRsefeup8cebUqEpARPtlv5vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744519; c=relaxed/simple;
	bh=sv3bHJPSIAzAatSQs/bKdLt9FMtfOseslXyoRcccdI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eolUDSrU3A7h0uT9BnwS2h3t8INp1PkfnEbSV2KNtnOSZpGk1zJj51V43HEIA0avPfPxamBTtUGQoBWjxJhTjWt3N48T5TqCxvZ3izRczQ944TcVPy/Vwzm72r3uPtYLbIt5RYBtRxmNLkxsRYqpOvShDBD1u+S/w/7VliidDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxBbyXU3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f300b318cso2189440e87.3;
        Fri, 03 May 2024 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744516; x=1715349316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORf4L+Kc1pyBC8fE9YC0FQfG86LMRHTWb3C7SJM7A84=;
        b=WxBbyXU30hDbBrK4+XsGK7kl5XkJsHGLFWLrgLFfhiIuzrztIorEMiBPnYQ8FqJIwN
         28ey8tqZvfBezT1urhrUK3/YK6oxecPc+9lzsnhhJHV+zHGxqKlnDGkW3uqI6TyELCAu
         U4UEs6kb9sgF0ys7t3LvFWOqqwXfMC2weTfLJiVcp9vM+6Hir6JznYy6IVURKMMh7vfW
         zcu/EIWa7HmlczyFOHtTBrmroWgYgNlY8cExlRtknrhtCHfe2vYynNIS4H1+Mn7NgwcH
         V1XWVokztOyjrOaNbJBsuECTugkQhxJZ1t1SQ0jZhRD+sKgYl34ysi3pZUPa4iBHzTnM
         vw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744516; x=1715349316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORf4L+Kc1pyBC8fE9YC0FQfG86LMRHTWb3C7SJM7A84=;
        b=cxALVQF+TW+o6o8/M2B68Du+YBkMyovqh1+IXO4c6qDiLy/L02hykDWO6xUAM8A94H
         k7KxzDfelTLl+QqfAluWIX7dKb983EhmxMWnHkoyUz9l2V/SYszZPyeQFHeHflZ5CN6c
         pKJybIuvfHt4mgfCVZWd/f2KalxDRceuQesA0OjJbhqkX0rchlvRO2ngExg0KqJev12/
         iyxXlrNWN8imm9wvnWDgNL5MEf9V2vsnpUsgVze/Th3eF0w+8NVCTiFsjju9L3qrknOv
         6S2EzEbb8IP+WKpxppB77vUi0DWVE9//50MK/yn9EN3x5Ut1unNxCSACRP0QzkkpspNw
         mJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJHOm6BlgQakxsP/6F7dgxCsyyeC988Fen8puG32wG59f+xpa9IpjaVa8c/FgBWPGav0PENC6gPxRrSGR6kec3bTWRecOL99YTe6La3lwmzWKWYwVnE+Qfm8//5fWW3Rbzs3QPfYZGWFhEsHTBimwwMf5cAPsKxOsW8wbpmvIQDFZaYaY=
X-Gm-Message-State: AOJu0YwwsismQJYl6r3G17j7G8rLmqjlk0TkyRYnfSwPdSobjRi7uhdY
	04swak0Fj3dJyZ5gGi4gFT4qK4nt3a54e1DSjsk2PTW8eELIEaPV
X-Google-Smtp-Source: AGHT+IHoIOWWYxlkRhBSBNJXE/IzGLljtcG1kJb12pS/KFp47uwFNQYN9JCC8XuHftITEOjOWMAKow==
X-Received: by 2002:a05:6512:3c9b:b0:51d:b7fc:29a6 with SMTP id h27-20020a0565123c9b00b0051db7fc29a6mr2456632lfv.7.1714744516178;
        Fri, 03 May 2024 06:55:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:15 -0700 (PDT)
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
Subject: [PATCH 6/6] mips: bmips: dma: drop redundant boot_cpu_type in arch_dma_sync
Date: Fri,  3 May 2024 15:54:07 +0200
Message-ID: <20240503135455.966-8-ansuelsmth@gmail.com>
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

Drop redundant boot_cpu_type in arch_sync_dma_for_cpu_all. These needs
to be parsed only once and we can make use of bmips_rac_flush_disable to
disable RAC flush on unsupported CPU.

Set this value in bmips_cpu_setup for unsupported CPU to skip this
redundant check every time DMA needs to be synced.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/dma.c         | 5 -----
 arch/mips/bmips/setup.c       | 1 -
 arch/mips/include/asm/bmips.h | 1 +
 arch/mips/kernel/smp-bmips.c  | 7 +++++++
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 799cc3e12fc3..e9af34f82dcd 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -11,11 +11,6 @@ void arch_sync_dma_for_cpu_all(void)
 {
 	u32 cfg;
 
-	if (boot_cpu_type() != CPU_BMIPS3300 &&
-	    boot_cpu_type() != CPU_BMIPS4350 &&
-	    boot_cpu_type() != CPU_BMIPS4380)
-		return;
-
 	if (unlikely(bmips_rac_flush_disable))
 		return;
 
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index bef84677248e..d27043b10405 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -40,7 +40,6 @@
  * with "mips-cbr-reg" in the "cpus" node.
  */
 void __iomem *bmips_cbr_addr;
-extern bool bmips_rac_flush_disable;
 
 static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
 
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 3a1cdfddb987..4a48c8f1077e 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -82,6 +82,7 @@ extern char bmips_smp_int_vec[];
 extern char bmips_smp_int_vec_end[];
 
 extern void __iomem *bmips_cbr_addr;
+extern bool bmips_rac_flush_disable;
 extern int bmips_smp_enabled;
 extern int bmips_cpu_offset;
 extern cpumask_t bmips_booted_mask;
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 7bde6bbaa41f..63534af367c7 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -681,6 +681,13 @@ void bmips_cpu_setup(void)
 		"	or	$8, $9\n"
 		"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
 		: : : "$8", "$9");
+
+		/* Disable RAC flush as not supported */
+		bmips_rac_flush_disable = true;
 		break;
+
+	default:
+		/* Disable RAC flush as not supported */
+		bmips_rac_flush_disable = true;
 	}
 }
-- 
2.43.0


