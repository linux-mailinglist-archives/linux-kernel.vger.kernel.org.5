Return-Path: <linux-kernel+bounces-161455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362C8B4C2E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BF11F21443
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4C915CB;
	Sun, 28 Apr 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrFjdGZs"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071041E498;
	Sun, 28 Apr 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714314705; cv=none; b=t479Psz7XVlSTi5LeOfpEL48AbbTQ0hk74m41/4DBLHUfVGtxeFLQ795oblNmhN+k8R9lAWo8mEEitSzroxVuAyhvOHsZ61MeaSBOcppO7jG4NUMaefvL1XyTs0lw5YSQPkFJhAl8U+FjzH4G+jsQ5FuVzmYeWl+U/TIXuB5FBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714314705; c=relaxed/simple;
	bh=VWwqUt3ObljQnJWmZQZlZdJq0jPe4CHthnCK33+nbig=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPTtgApPh6j6lEUITvXzDdbHbvf/L1oxdEhceYyD/KkHN6Z2SNnC97S0UNBuA1FD+rBDdjK7t7otv7Ld0gdlCNa8NOQ6z6wjVC5Na6vH77LydpgHCw9sXv0LEdYLLbJGaY8jnhvRfcUaIBw7RSdtCdevWd4PrW8VUTnfiZAZWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrFjdGZs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eab699fcddso27452835ad.0;
        Sun, 28 Apr 2024 07:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714314703; x=1714919503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXqf8F3SecFIk6T1Akuz7f4j9GlOgRtt8O4mjizvpu4=;
        b=jrFjdGZs/PCCnjDGsdPTfayQ3lLfoFRrbuxvBoIoVAIqcK5N5ZRN4DVHbmK7LllBFy
         O3+osq+Xvqtm8YlIqNlFmmv5l3EAUEtc419DSOWs20wYmLD2R2JKL23GCPVEA3FWDaH4
         uMbkqP0w1qOjNQEI9/ucRevnUUBz+ExvesXPCQ4SruRn/POb/d2l6+IfqscNf5UR7Xsp
         Y1ZdwJuRz76aGC5Q9fTNUjTxSGTqEtoyd/VZMpF8XEaKM7iFtkm+rNhZAy73pfxdoi9Y
         bg9XgBPoaNX4l5pdWc4dDPZ21IQ7qxZ+4H0JUwcAmZcfdCjuFf90onoCuAqthrXcbx8m
         Q7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714314703; x=1714919503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXqf8F3SecFIk6T1Akuz7f4j9GlOgRtt8O4mjizvpu4=;
        b=XXcoSJVs8XnSYURb4E1R7a2geSYaxTshMYkjQ738W2BAkKbUerMEy9p0AVru+nj5e0
         hXJD083WkDVVpmI38xyBA/oiRkGBFTUCaO7juRZysUt3jqBMIpzCnGSPddggG0+NBFKK
         rzudm26GF7hpbS03eixIf9wv8bU4U8SICgF8n7jFKn/q5jTuoZJ2Zp+aSGpQgz95QYlz
         UWYxN4ttBKQpAMqHL78POJtbKG8C2980IpzlaZbxh1gz0YXPnZlGjnqt0CjmCiRfD7OJ
         cJyKiYl4D+ey08ceujj1z94WVqWuPP+XuuGXdYQ7aQUy5eqUW1obqwFlf2WuaWMNRGOk
         0GMA==
X-Forwarded-Encrypted: i=1; AJvYcCWe6e87RPHT9pTaYfn1DRq5J1JrkjFFdIDLNRBuYZ+JBTNMnE14NdlaZt4+1GVZs4VK0JSetDMZ0XSSAQEB7Zal4tAnzlA/qnN5QQpBY5A1JgV8tAgSix7Nd1ti0S8MQeH5wxqNDlm3pEyYTC4=
X-Gm-Message-State: AOJu0YzILsZe5rGxXeBCrafdPYIuzROc2PeXcK/8nZ88zyr6QVW44mzm
	paR3lD0aVWPq1d5wj5M5pjC4zjTdxsBbAeZ89+QFJCg0KYyLjbDfvrIghw==
X-Google-Smtp-Source: AGHT+IG6q6wHxQ91YJnCTGvVZFyYo0xYdTvqDFb5dXnQuTlsuMiga8xv5uzQdfDtcGTXR7Y0kjbYHg==
X-Received: by 2002:a17:902:fc4d:b0:1eb:2988:549d with SMTP id me13-20020a170902fc4d00b001eb2988549dmr8241260plb.40.1714314703323;
        Sun, 28 Apr 2024 07:31:43 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00612dc2ec375sm1034834pgc.16.2024.04.28.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 07:31:42 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
Date: Sun, 28 Apr 2024 22:29:36 +0800
Message-Id: <20240428142937.785925-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set. However, this bit can be clear when
watchdog register 0x0c bit1(Reset System after timeout) is enabled.
Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
in ast2600 SCU74 or ast2400/ast2500 SCU3C.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 78 +++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..4393625c2e96 100644
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
@@ -22,10 +24,32 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+//AST SCU Register
+#define POWERON_RESET_FLAG		BIT(0)
+#define EXTERN_RESET_FLAG		BIT(1)
+
+#define AST2400_AST2500_SYSTEM_RESET_EVENT	0x3C
+#define   AST2400_WATCHDOG_RESET_FLAG	BIT(1)
+#define   AST2400_RESET_FLAG_CLEAR	GENMASK(2, 0)
+
+#define   AST2500_WATCHDOG_RESET_FLAG	GENMASK(4, 2)
+#define   AST2500_RESET_FLAG_CLEAR	(AST2500_WATCHDOG_RESET_FLAG | \
+					 POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
+
+#define AST2600_SYSTEM_RESET_EVENT	0x74
+#define   AST2600_WATCHDOG_RESET_FLAG   GENMASK(31, 16)
+#define   AST2600_RESET_FLAG_CLEAR	(AST2600_WATCHDOG_RESET_FLAG | \
+					 POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
+
 struct aspeed_wdt_config {
 	u32 ext_pulse_width_mask;
 	u32 irq_shift;
 	u32 irq_mask;
+	const char *compatible;
+	u32 reset_event;
+	u32 watchdog_reset_flag;
+	u32 extern_reset_flag;
+	u32 reset_flag_clear;
 };
 
 struct aspeed_wdt {
@@ -39,18 +63,33 @@ static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
+	.compatible = "aspeed,ast2400-scu",
+	.reset_event = AST2400_AST2500_SYSTEM_RESET_EVENT,
+	.watchdog_reset_flag = AST2400_WATCHDOG_RESET_FLAG,
+	.extern_reset_flag = 0,
+	.reset_flag_clear = AST2400_RESET_FLAG_CLEAR,
 };
 
 static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
+	.compatible = "aspeed,ast2500-scu",
+	.reset_event = AST2400_AST2500_SYSTEM_RESET_EVENT,
+	.watchdog_reset_flag = AST2500_WATCHDOG_RESET_FLAG,
+	.extern_reset_flag = EXTERN_RESET_FLAG,
+	.reset_flag_clear = AST2500_RESET_FLAG_CLEAR,
 };
 
 static const struct aspeed_wdt_config ast2600_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
+	.compatible = "aspeed,ast2600-scu",
+	.reset_event = AST2600_SYSTEM_RESET_EVENT,
+	.watchdog_reset_flag = AST2600_WATCHDOG_RESET_FLAG,
+	.extern_reset_flag = EXTERN_RESET_FLAG,
+	.reset_flag_clear = AST2600_RESET_FLAG_CLEAR,
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
@@ -310,6 +349,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
 	struct device_node *np;
+	struct regmap *scu_base;
 	const char *reset_type;
 	u32 duration;
 	u32 status;
@@ -458,14 +498,36 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
-	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
-
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
-	}
+	/*
+	 * Power on reset is set when triggered by AC or SRSRST.
+	 * Thereforce, we clear flag to ensure
+	 * next boot cause is a real watchdog case.
+	 * We use the external reset flag to determine
+	 * if it is an external reset or card reset.
+	 * However, The ast2400 watchdog flag is cleared by an external reset,
+	 * so it only supports WDIOF_CARDRESET.
+	 */
+	scu_base = syscon_regmap_lookup_by_compatible(wdt->cfg->compatible);
+	if (IS_ERR(scu_base))
+		return PTR_ERR(scu_base);
+
+	ret = regmap_read(scu_base, wdt->cfg->reset_event, &status);
+	if (ret)
+		return ret;
+
+	if (!(status & POWERON_RESET_FLAG) &&
+	      status & wdt->cfg->watchdog_reset_flag)
+		wdt->wdd.bootstatus = (status & wdt->cfg->extern_reset_flag) ?
+				WDIOF_EXTERN1 : WDIOF_CARDRESET;
+
+	status = wdt->cfg->reset_flag_clear;
+	ret = regmap_write(scu_base, wdt->cfg->reset_event, status);
+	if (ret)
+		return ret;
+
+	if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
+	    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
+		wdt->wdd.groups = bswitch_groups;
 
 	dev_set_drvdata(dev, wdt);
 
-- 
2.25.1


