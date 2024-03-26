Return-Path: <linux-kernel+bounces-119252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B188C62F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E243069CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D413C832;
	Tue, 26 Mar 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcyKEEem"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC813C82D;
	Tue, 26 Mar 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465250; cv=none; b=PiJ5wc2NCX8KtLiiRS+1RHCPxIS7ejQkMhRgaTvxB6cOsTz53ScXuJqY91XQbnM8vGqwnvchKi7OjBBgs+gSWTb75cdqaZBqeUvte/ubRzJE0BoMZOx2DrAfi+CS5JlUomgXrzT/j7QnUoit2eImevqnmphmrplJBSyStBYG7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465250; c=relaxed/simple;
	bh=pdFwi5vtNrKZeNALNYwLixoxGMXi0UyYvxxlVlUCD0M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpkOqHZ9d25a80Qcp4KpCCNU+6FpTWXMV4mTJUod38jEhqAPI+u6J+ORZEAHJ9hp/9D6tURBqiHhH5Gh7EGiURdzOXM9A8p17+k4zgVFeCroeAPaYL9Sk0Hw0s+DJBVywfz+6o/UqxzCFuWQX8qHNudJg9BLQNeNlg/c1PVh0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcyKEEem; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so2481670b3a.3;
        Tue, 26 Mar 2024 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711465248; x=1712070048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxIIBTP4rXppfPhTT/4q0S1EVkuGtE5Ah2bvfj9/Kl4=;
        b=gcyKEEem0DFob2sI1L0xA6gdTtrEeKTXRMNOy6AmIdu+axpXnt1illAHPVH5ZBEwtR
         i+Y5vrIgRrk/G56yehIdoMsLOgbMxYYCicMW7UKHaVuwdPRZBoInjcwIzNwSGdn5ZWuc
         0A6AQiC6A11UoiQPhXflaZiNpYpc1sHwPXbY60SUnR8R26E0DLhT3Bq7xR0F8/lAV/ut
         O56TGbe/q6sX+R1MGKCVNqj9nKkLJLMYxVg2Wcvs3vERxDtZOjDNBxk5yf1Ngo97Hv2W
         uJoz6YjOUmOG74nS2mKcjMxaFhoKiVbxuEDrIIoCGkiiNshYE/2dSowJhCPIwYodsBg0
         XQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465248; x=1712070048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxIIBTP4rXppfPhTT/4q0S1EVkuGtE5Ah2bvfj9/Kl4=;
        b=xMo/1SmA026zyNvsUZQ6h+FnCYxvj0dPp+krzvLQ0eoM9OodF3+5WuaRO2ygwt9A9l
         vB0Y9Bz64xLaGSqmMSLaLXwAN0BdHLnvegxYV3cc9LA/W0Sop38k1AFuPggOThiQ2COK
         YBrIIfDzxuCWA9I2BHtncuMs/aBXH7JlXQ7GnRz8QoilJHBymjvsCEe6F7Psh6m8gOft
         Pin3DMnkDD2JNqRlwSgJKDP67CZDcAIFr8yWC6Rt50DxEPbpI9DXvrKuxCe2n42ldL82
         VKzWunA1dHWVyDE7iyA6Ohl4ZcU89EzyRPrsfsVrRwkHKw1Qp9gIRgM+7XXZWWF27E9/
         H9EA==
X-Forwarded-Encrypted: i=1; AJvYcCU2eFaWS7wHXOEGdR52axpCbAk7ahZDGKJVEIUaECDvwBWNZFKNDZHkXr6+f488pfCK2qBVpY82ToGkdCQ5yC2QqieIuxRf9Kj3QFznVy2j+CCImXrtqjGgTL/ZIzTcDyEKUEnPTc4LocEJ0/qwJicxNqJOSIyduBo8va191qcf5xhutmaDwW2F
X-Gm-Message-State: AOJu0YwMGGeGHAW7dcfY0/RUscoTdSVuiaa0Oyfgaw2y35FkYsVLXq68
	RpssDsTPB9Ch6M1z0F5UNawjImAk/iDHDesRjy744iBZimGzR0kL
X-Google-Smtp-Source: AGHT+IH1cX47UcVDJeEEPc3BtsiLHnch3pmt/eT/zXRUGHXwiIA0NbF5hbSlAoW8eYDLcPteprOuGw==
X-Received: by 2002:a05:6a20:6a22:b0:1a3:c3e6:aef7 with SMTP id p34-20020a056a206a2200b001a3c3e6aef7mr7554771pzk.54.1711465248497;
        Tue, 26 Mar 2024 08:00:48 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l27-20020a635b5b000000b005dcbb855530sm7658404pgm.76.2024.03.26.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:00:48 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Tue, 26 Mar 2024 23:00:27 +0800
Message-Id: <20240326150027.3015958-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
References: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set.

Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
ast2500 SCU3C when bit1 is set.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 53 ++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..52afc5240b1c 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -11,10 +11,12 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -65,23 +67,32 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_RELOAD_VALUE	0x04
 #define WDT_RESTART		0x08
 #define WDT_CTRL		0x0C
-#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
-#define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
-#define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
-#define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
-#define   WDT_CTRL_1MHZ_CLK		BIT(4)
-#define   WDT_CTRL_WDT_EXT		BIT(3)
-#define   WDT_CTRL_WDT_INTR		BIT(2)
-#define   WDT_CTRL_RESET_SYSTEM		BIT(1)
-#define   WDT_CTRL_ENABLE		BIT(0)
+#define WDT_CTRL_BOOT_SECONDARY	BIT(7)
+#define WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
+#define WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
+#define WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
+#define WDT_CTRL_1MHZ_CLK		BIT(4)
+#define WDT_CTRL_WDT_EXT		BIT(3)
+#define WDT_CTRL_WDT_INTR		BIT(2)
+#define WDT_CTRL_RESET_SYSTEM		BIT(1)
+#define WDT_CTRL_ENABLE		BIT(0)
 #define WDT_TIMEOUT_STATUS	0x10
-#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
-#define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
+#define WDT_TIMEOUT_STATUS_IRQ		BIT(2)
+#define WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
+#define WDT_TIMEOUT_STATUS_EVENT		BIT(0)
 #define WDT_CLEAR_TIMEOUT_STATUS	0x14
-#define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
+#define WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
 
+/*
+ * Ast2600 SCU74 bit1 is External reset flag
+ * Ast2500 SCU3C bit1 is External reset flag
+ */
+#define   EXTERN_RESET_FLAG		BIT(1)
+#define   AST2500_SYSTEM_RESET_EVENT	(0x3C)
+#define   AST2600_SYSTEM_RESET_EVENT	(0x74)
+
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
  * enabled), specifically:
@@ -458,15 +469,25 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
+	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
+							     "aspeed,scu");
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
+	if (status & WDT_TIMEOUT_STATUS_EVENT)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		regmap_read(scu_base, AST2600_SYSTEM_RESET_EVENT, &status);
+	} else {
+		regmap_read(scu_base, AST2500_SYSTEM_RESET_EVENT, &status);
+		wdt->wdd.groups = bswitch_groups;
 	}
 
+	/*
+	 * Reset cause by Extern Reset
+	 */
+	if (status & EXTERN_RESET_FLAG)
+		wdt->wdd.bootstatus |= WDIOF_EXTERN1;
+
 	dev_set_drvdata(dev, wdt);
 
 	return devm_watchdog_register_device(dev, &wdt->wdd);
-- 
2.25.1


