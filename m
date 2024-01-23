Return-Path: <linux-kernel+bounces-35812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67D8396DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE27D1F2470C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042978121F;
	Tue, 23 Jan 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoQdUdd6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9A81208;
	Tue, 23 Jan 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032159; cv=none; b=AcecirUAylxE1pb8CXjKIwsm7xUj/KgJJsV1lNXGE/jyy0mnnogQOJHjOWO87h15nicWlBxC1YZ8Ivnu5E5/ig8vm9LW0IiT10lcAXAVhagzvYw1fvwV17nAdn8LEwnSMxTywCmsBo03/HyZAroHxvF5GNHrO9YSnA77cozkxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032159; c=relaxed/simple;
	bh=x1ciq3Ect+XnKhvC9H5DKv0iPFUte+VpAip+Ss55L9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XB8E18UouhCKGFgURPVLGx5PHpbCP4l//ygs3YkV5VU822dC8NEGDH6VcLsShbqEqg8XEsAXPkssXC8tSoSyzjC1y00hCDXZwEpvDVosPy+hCdVbNyEt54CsRmvwmbt26cHl8DnkX+/0SUdj3IxxKH/pPvoeDAVjOy+IKX+mHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoQdUdd6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d720c7fc04so25424165ad.2;
        Tue, 23 Jan 2024 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032157; x=1706636957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDS294tSCgcvUh/yn3ryUeNvBf4lRbYL7mm8287k4Lg=;
        b=RoQdUdd6Qs7Psa2pLkRzNSNOIaI/Yg/kOsQvIyGHW/b6yvtH6Aps07Q8KgdLABtVt1
         VzRM6LQ4/IeDOyaIblmHkq1YtPMVcLSRSYvPS0bJ0xQ+YZ+FZXb0rIBUfXQ2VuqIkJ0P
         5aE17LcRcf3a5MqaPK7xAWWmE/JvU5GlOANuD6CYG9Xx1yVHGTNzDaQH3qHEfQMoeSLj
         Rs5YuW8mXH2n/CStRAyc+F0pQuoqQP2EM8Sp5RCOm15+2iIV/fS11CMG+rebdkcAqT7Q
         tQprhy5Zcn8z3FISedswd39W6hXIJtTOtH8thHsI389bJjDQPTXox5J+wtiMuWeBluHc
         g2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032157; x=1706636957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDS294tSCgcvUh/yn3ryUeNvBf4lRbYL7mm8287k4Lg=;
        b=ZKVmfZpz2IHPVRD90972hPzBwTXaCbgISGerhqnYlIfXBurRJ3mWSM4tRSV/83Mlmq
         +lC7BfpvgMEC0ZAJ24fFfpU+ygVH32+5w6PHmCdw239Ub96Q3zdMs0HcXwbRw5MSxf00
         wbZxqg2Va7LkmIhGCk06YHZQQtfufdi1jBoL0K88ebYa5U5GtGvTH+TOBkRLoVYrUN1Z
         FYvDa23LptPWyK7dfcXGhuN5Zay7UpQhNZp096+b/pkCE6qcQDuzuVqbaA4Lmu09yQ/V
         oELa/ho5rYPRsMhoHCitEz2ZBAGQ3RJ7Tlohw68SK5jmQvISO6TKFdRwbo+u1ND8VU+b
         DggA==
X-Gm-Message-State: AOJu0YzdUOeHxKqO6QDV98WqBa6kXuFlPsUPQSUIzQMI1N3jBO8tVwwb
	WxhEQl4+YOonHZoEHtE31Qn8UREGT58+3zwYnXAUl9UTVzD09TJDigI2KMeC
X-Google-Smtp-Source: AGHT+IF5BDObdHwJFaV3mcAncY4llNAIARhElT5nS80U8qdnFsrWJL3ZXXt4SggollmDTITqqhmu0A==
X-Received: by 2002:a17:902:e547:b0:1d7:620e:d2d8 with SMTP id n7-20020a170902e54700b001d7620ed2d8mr2366339plf.41.1706032156595;
        Tue, 23 Jan 2024 09:49:16 -0800 (PST)
Received: from eldorado.. (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902900100b001d5e7221082sm9104100plp.238.2024.01.23.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:49:16 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: jonas.gorski@gmail.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] MIPS: BCM63XX: Fix missing prototypes
Date: Tue, 23 Jan 2024 09:46:54 -0800
Message-Id: <20240123174701.210922-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the symbols for which we do not have a prototype can actually be
made static and for the few that cannot, there is already a declaration
in a header for it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c | 2 +-
 arch/mips/bcm63xx/dev-rng.c               | 2 +-
 arch/mips/bcm63xx/dev-uart.c              | 1 +
 arch/mips/bcm63xx/dev-wdt.c               | 2 +-
 arch/mips/bcm63xx/irq.c                   | 2 +-
 arch/mips/bcm63xx/setup.c                 | 2 +-
 arch/mips/bcm63xx/timer.c                 | 2 +-
 7 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 01aff80a5967..99f321b6e417 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -702,7 +702,7 @@ static struct ssb_sprom bcm63xx_sprom = {
 	.boardflags_hi		= 0x0000,
 };
 
-int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
+static int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
 {
 	if (bus->bustype == SSB_BUSTYPE_PCI) {
 		memcpy(out, &bcm63xx_sprom, sizeof(struct ssb_sprom));
diff --git a/arch/mips/bcm63xx/dev-rng.c b/arch/mips/bcm63xx/dev-rng.c
index d277b4dc6c68..f94151f7c96f 100644
--- a/arch/mips/bcm63xx/dev-rng.c
+++ b/arch/mips/bcm63xx/dev-rng.c
@@ -26,7 +26,7 @@ static struct platform_device bcm63xx_rng_device = {
 	.resource	= rng_resources,
 };
 
-int __init bcm63xx_rng_register(void)
+static int __init bcm63xx_rng_register(void)
 {
 	if (!BCMCPU_IS_6368())
 		return -ENODEV;
diff --git a/arch/mips/bcm63xx/dev-uart.c b/arch/mips/bcm63xx/dev-uart.c
index 3bc7f3bfc9ad..5d6bf0445b29 100644
--- a/arch/mips/bcm63xx/dev-uart.c
+++ b/arch/mips/bcm63xx/dev-uart.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_uart.h>
 
 static struct resource uart0_resources[] = {
 	{
diff --git a/arch/mips/bcm63xx/dev-wdt.c b/arch/mips/bcm63xx/dev-wdt.c
index 42130914a3c2..302bf7ed5ad5 100644
--- a/arch/mips/bcm63xx/dev-wdt.c
+++ b/arch/mips/bcm63xx/dev-wdt.c
@@ -34,7 +34,7 @@ static struct platform_device bcm63xx_wdt_device = {
 	},
 };
 
-int __init bcm63xx_wdt_register(void)
+static int __init bcm63xx_wdt_register(void)
 {
 	wdt_resources[0].start = bcm63xx_regset_address(RSET_WDT);
 	wdt_resources[0].end = wdt_resources[0].start;
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 2548013442f6..6240a8f88ea3 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -72,7 +72,7 @@ static inline int enable_irq_for_cpu(int cpu, struct irq_data *d,
  */
 
 #define BUILD_IPIC_INTERNAL(width)					\
-void __dispatch_internal_##width(int cpu)				\
+static void __dispatch_internal_##width(int cpu)			\
 {									\
 	u32 pending[width / 32];					\
 	unsigned int src, tgt;						\
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index d811e3e03f81..c13ddb544a23 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -159,7 +159,7 @@ void __init plat_mem_setup(void)
 	board_setup();
 }
 
-int __init bcm63xx_register_devices(void)
+static int __init bcm63xx_register_devices(void)
 {
 	/* register gpiochip */
 	bcm63xx_gpio_init();
diff --git a/arch/mips/bcm63xx/timer.c b/arch/mips/bcm63xx/timer.c
index a86065854c0c..74b83807df30 100644
--- a/arch/mips/bcm63xx/timer.c
+++ b/arch/mips/bcm63xx/timer.c
@@ -178,7 +178,7 @@ int bcm63xx_timer_set(int id, int monotonic, unsigned int countdown_us)
 
 EXPORT_SYMBOL(bcm63xx_timer_set);
 
-int bcm63xx_timer_init(void)
+static int bcm63xx_timer_init(void)
 {
 	int ret, irq;
 	u32 reg;
-- 
2.34.1


