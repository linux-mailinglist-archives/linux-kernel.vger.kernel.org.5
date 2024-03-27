Return-Path: <linux-kernel+bounces-120575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BD88D99E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC37B21C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE245BE9;
	Wed, 27 Mar 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl2/c4cz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899D40849;
	Wed, 27 Mar 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529635; cv=none; b=R4UgTZ3lcwzS6Bw5s7wwcXdpJCtUNTx4CFgyyZrJZLEbC4Wqv43BSvcZg9hBC1Qbmzu3nz6nA0e61AOZ4dLLaPSUdKiRTFd2ky/3VlqHhMCDHc2Y8qo8w2GbNY5taNzYxF8unWhVJRQk/GIhpS632o0G6GZKWE5OizOfOAD7cLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529635; c=relaxed/simple;
	bh=mEMpsvf/Lu9Dlvkkk/Qka3rYdQiTY2A48dn0KD6WLwI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1fvikrLkQLJ/WbuoHi5raTQvhiVnjPdbH7Pzb+bSCx9LPTwzL8qMMZr8Ma/NDyUUOFw1pVcpCOzqSESDAkij6RputY7iIF/4o2vksqzLVWsmTMZkTCFYZI6Zb9w0WgXfNHKMLzgQ34DgV7MIMVk+8AetzV4qiPqzH5SUVHWLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl2/c4cz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0f0398553so14861615ad.3;
        Wed, 27 Mar 2024 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711529633; x=1712134433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZEbTSOw9EjuXuuOhzMwhOK0HhVADXjRmiePaMQf/CY=;
        b=Tl2/c4czTvOoLPfdZIzFxIQ1bi11G3C7p7fv+Vv7AnXVjXr5opULz/A1e8g3TDnoV5
         K1iooePHEwRugKpFkwsdRn+PN1qgnK9voZxlXZd32q2+iV0p6wOJrVQYux+q1jqff1qx
         /qL36//STvQKPjnmdoVHtDRwoItqX8fkZdKtyEIORxMH8CqQy0B/XfKOvkT6XKtsM22A
         e/5m85dv2ICzDoYaqBrWVgPrFcvZKIx4+DYogb19cZZrUIOedgmNdgnVE+h1NGwybxFs
         oF4HLgoLggsUBky4QT+Lv4MXfMRHzQLJicNrkbt2LlvBQrUkV+jZYXVIRd50jKTG3t+0
         rVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529633; x=1712134433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZEbTSOw9EjuXuuOhzMwhOK0HhVADXjRmiePaMQf/CY=;
        b=d0Xai2EF0QjKCC8osRwVQLjKkjHrQ4+l/0qjxXLIPKBGhNkXvk7S6apqhk+kalVnPt
         V8z0FH15Hw1QG1SBJORut/sPhyNHXlDsbMnIN2iVzVETjsw4AHUTepo52AkOK4IL3cmh
         f+Qu/cG/eaDhZIkD67J1HvM5NMzCZkQ820kiDOitosBocpMrCTL+z/0PSQ3/A6U4fHO8
         uAh6s5Ge99ph+EZIQFJNSXSWpo0S/Ewt6oYSwSG3fzGeMw//MoPP49Bl+AEThMsGo37J
         qaezi1tACqfPokvwEjdPg4PGpIFQPdAl8WIjC0nHlse5q5QLs76KN6n1vvukwaa1NGlL
         U/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLGubckVlm+g6C/OXvEDXMgRSmV7BbhcUpU4jCSfNkaJUfynAy51ubMT4LNRDVYBGllrqUdddhH/QxrzkQbcvGsWm2IovWNF/M79LZWQzni1uJ3ftw6apLID077No53Pef1s226do1gdG/5kR2oDeDdBDEh3zO/RGo6ctZwc0EE3Gs0M1NWqek
X-Gm-Message-State: AOJu0YxVR+z1nWWgMHTSp7E2fEmaFOpBv298V6Cx0oulXfDWKHA2VTmk
	hIQ5rULOAMRDpvIm0+QGJNxUH8kBM825GTNwQMHrcp05meqmU5bh
X-Google-Smtp-Source: AGHT+IFlw6rOiGuhTJ4vNythc7vqhRqSyiMQo9PeosfY33Phf1K75pTfq+88EaBWSjn9tJXb1tX3pQ==
X-Received: by 2002:a17:902:c94a:b0:1e0:acb1:7977 with SMTP id i10-20020a170902c94a00b001e0acb17977mr785333pla.49.1711529633261;
        Wed, 27 Mar 2024 01:53:53 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e383-3566-013c-5a87-9abc-381e.emome-ip6.hinet.net. [2001:b400:e383:3566:13c:5a87:9abc:381e])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001e0501d3058sm8356848plb.63.2024.03.27.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:53:52 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Wed, 27 Mar 2024 16:53:30 +0800
Message-Id: <20240327085330.3281697-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
References: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
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
 drivers/watchdog/aspeed_wdt.c | 60 +++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..29e9afdee619 100644
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
+#define EXTERN_RESET_FLAG		BIT(1)
+#define AST2500_SYSTEM_RESET_EVENT	0x3C
+#define AST2600_SYSTEM_RESET_EVENT	0x74
+
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
  * enabled), specifically:
@@ -330,6 +341,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
+	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
+							     "aspeed,scu");
+	if (IS_ERR(scu_base))
+		return PTR_ERR(scu_base);
+
 	wdt->wdd.info = &aspeed_wdt_info;
 
 	if (wdt->cfg->irq_mask) {
@@ -459,14 +475,26 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
+	if (status & WDT_TIMEOUT_STATUS_EVENT)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		ret = regmap_read(scu_base,
+				  AST2600_SYSTEM_RESET_EVENT,
+				  &status);
+	} else {
+		ret = regmap_read(scu_base,
+				  AST2500_SYSTEM_RESET_EVENT,
+				  &status);
+		wdt->wdd.groups = bswitch_groups;
 	}
 
+	/*
+	 * Reset cause by Extern Reset
+	 */
+	if (status & EXTERN_RESET_FLAG && !ret)
+		wdt->wdd.bootstatus |= WDIOF_EXTERN1;
+
 	dev_set_drvdata(dev, wdt);
 
 	return devm_watchdog_register_device(dev, &wdt->wdd);
-- 
2.25.1


