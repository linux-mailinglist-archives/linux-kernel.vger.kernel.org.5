Return-Path: <linux-kernel+bounces-34697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB717838640
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830451F24BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD21866;
	Tue, 23 Jan 2024 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph/jz0pP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329711848;
	Tue, 23 Jan 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705982906; cv=none; b=odetc/PBwh9QwkuH17zgPNu0jHs6mXCE3hT+hnyZQ923ehXWSEK0gUWpS/q9dPGsUudXZY986LB3MrhMwFQjAg8gsmTitLoGzdDGwBRjyOQhNdxk/z4WYsa5P7xHP/3RDrDvVD86Tzj3VpVYR0Y3QK9AoEnPYT7X6whZjl0xDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705982906; c=relaxed/simple;
	bh=UIWLpFywju+Oooap054XNWL228gqbVBCuVvK5+/Z0Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aTPeLLhEgy4wrGIDoSsHs2qlsFNDocDqEID/fm/JdxSxlHQ+2ydfvWPIErBtGW65Nn8m7XCxLETbm1Q0+qKRSizo4UJbFQ8tvdOmz6LKIUWtNH/7vthBA3ZuWkpPGJk1xhXM10Dja9Fv1s+eLQVAxDAwYgUv80yn6zI8c5Y2pDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph/jz0pP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5f252411aso20212125ad.2;
        Mon, 22 Jan 2024 20:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705982903; x=1706587703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmdQPu2DwapL3rjaJJ6hE3+x7BtIY9+ECFVDwOkzgX0=;
        b=Ph/jz0pPCwK/9HuTkdZ+XBQyq4G9E+UXGcSTsZuuWXqFgiE7ad3rvempzNhmfrQAUN
         8YT7qjFiY+OQe4PvnV1EnWkcuNaQnjnvXRazO/fdr4T0hwdvfnAgudRfYub2bPCatxk/
         05kP8o5yUQ215Qo6WUGiVSYjVIYp3M1Z03g0LBVJ5LX5NWNwHeY4LgWBa0+pFMgn1DDv
         egTBuLxJph8j3+ePXD5bjoMZFC1KjBVzXz+sFMT41kZt6oHcKRcDj8vDGNRBur1rDmzQ
         WDtI6DBkvMNxKn/IQVpbZRhOvrMHa00zYm8fcWeV/ZsZGTywLd1XHw9EuV0tbsSfkA8w
         USAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705982903; x=1706587703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmdQPu2DwapL3rjaJJ6hE3+x7BtIY9+ECFVDwOkzgX0=;
        b=lE4tcBiqQy+ZKOJvhNU/dxw7kkCq0lw0sIVe76pIVVEmuX2TLkh6FKRwcBAFojpd84
         amnFPBByX5uJa2HX+mkN8ysqTsrP+6KN5UohlAv80SsRWbjwFDQ3rfX/2hn+rnwEf/nN
         Z3aGxpHtq04EtTf7M+xc7N9zu5oKLkL7DTgoM3AzPow6ZzraiNLvW/iUY5htrToMuzHM
         Q52y3+A8zzK5PSnhuRnYBYrMtqhJ+08xwsNI7AKRjKF8fs7UriefDWoxvTgcWDtWLoZK
         2HUO/b0NubfBf8d6cPLHtQxDhltY5oNphP0x6IYynce3o26kUQFofEIQj/s+X4bf70HH
         /N2Q==
X-Gm-Message-State: AOJu0Yx+Y5tlYhDlUjSRihGm1e7mBFo4/fqJaB6Nqtp8G8oHPgzTHzIq
	vzXmn92XG+2LzQzoe9+t7CpZY7ArliKvyruIKHiJNSdelpGATBZgljiLljTZ
X-Google-Smtp-Source: AGHT+IGNFMGce/I3hi71qXZeOfMVW3oaPmfI5DmnSUuaM7vcJZcJ6ZqWUn1a8GxnuA4oQpstobVDiQ==
X-Received: by 2002:a17:902:bf0c:b0:1d4:2266:64bf with SMTP id bi12-20020a170902bf0c00b001d4226664bfmr2686907plb.52.1705982902562;
        Mon, 22 Jan 2024 20:08:22 -0800 (PST)
Received: from eldorado.. (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id ks7-20020a170903084700b001d7083fe09asm7609658plb.187.2024.01.22.20.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 20:08:21 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: BCM63XX: Fix missing prototypes
Date: Mon, 22 Jan 2024 20:08:13 -0800
Message-Id: <20240123040817.200542-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a number of missing prototypes warnings for the BCM63XX machine,
fix those by providing adequate function prototypes.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h    | 8 ++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h  | 1 +
 arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h | 2 ++
 arch/mips/include/asm/mach-bcm63xx/irq.h            | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 1cad18e6681d..b9ab5ee1c7b2 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -1065,4 +1065,12 @@ void bcm63xx_machine_halt(void);
 
 void bcm63xx_machine_reboot(void);
 
+int bcm63xx_register_devices(void);
+
+int bcm63xx_rng_register(void);
+
+int bcm63xx_uart_register(unsigned int id);
+
+int bcm63xx_wdt_register(void);
+
 #endif /* !BCM63XX_CPU_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
index bcbece793fd8..f920c7274f5e 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
@@ -8,5 +8,6 @@ int bcm63xx_timer_set(int id, int monotonic, unsigned int countdown_us);
 int bcm63xx_timer_enable(int id);
 int bcm63xx_timer_disable(int id);
 unsigned int bcm63xx_timer_countdown(unsigned int countdown_us);
+int bcm63xx_timer_init(void);
 
 #endif /* !BCM63XX_TIMER_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index 830f53f28e3f..7b905c8a424d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -51,4 +51,6 @@ struct board_info {
 	unsigned long ephy_reset_gpio_flags;
 };
 
+int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out);
+
 #endif /* ! BOARD_BCM963XX_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/irq.h b/arch/mips/include/asm/mach-bcm63xx/irq.h
index b016f0615d5f..cbb92a609835 100644
--- a/arch/mips/include/asm/mach-bcm63xx/irq.h
+++ b/arch/mips/include/asm/mach-bcm63xx/irq.h
@@ -5,4 +5,7 @@
 #define NR_IRQS 128
 #define MIPS_CPU_IRQ_BASE 0
 
+void __dispatch_internal_32(int cpu);
+void __dispatch_internal_64(int cpu);
+
 #endif
-- 
2.34.1


